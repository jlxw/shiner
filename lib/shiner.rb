#require "shiner/version"

require 'rubygems'
require 'bundler/setup'
require 'pp'

require 'tactful_tokenizer'
require 'classifier'

module Shiner
  def self.shine(string, options={:max_length => 188})
    best = string_to_best_sentences(string, options)
    best ? best[:sentences].collect{|sentence| sentence[:sentence]}.join(' ') : ''
  end
  
  def self.string_to_best_sentences(string, options={})
    sentences = string_to_scored_sentences(string)
    batches = []
    sentences.each_index{|index|
      batch={:sentences => sentences[index, options[:max_sentences] || sentences.size]}
      next if options[:max_length] && batch[:sentences].collect{|sentence| sentence[:sentence]}.join(' ').length < options[:max_length] && batches.size > 0 #don't take last few sentences if they do not meet max_length
      next if options[:max_sentences] && batch[:sentences].size < options[:max_sentences] && batches.size > 0 #don't take last few sentences if they do not meet max_sentences
      batch[:sentences].pop while options[:max_length] && batch[:sentences].collect{|sentence| sentence[:sentence]}.join(' ').length > options[:max_length]
      next if batch[:sentences].empty?
      batch[:score] = batch[:sentences].collect{|sentence| sentence[:score]}.sum.to_f / batch[:sentences].size
      batches << batch
    }
    best = batches.sort_by{|batch| batch[:score]}.last
  end
  
  def self.string_to_scored_sentences(string)
    sentences=[]
    string_to_sentences(string).each{ |sentence|
      classifications = classifier.classifications(sentence)
      next if classifications['Uninteresting']==0
      sentences << {:sentence => sentence, :classifications => classifications, 
        :score => 1 - classifications['Interesting'] / classifications['Uninteresting'] }
    }
    #sentences = sentences.sort_by{|sentence| sentence[:score] }
    sentences
  end
  
  def self.classifier
    @classifier ||= (
        b = Classifier::Bayes.new 'Interesting', 'Uninteresting'
        File.read(File.dirname(__FILE__) + '/../data/interesting.txt').split("\n").each { |i|
          b.train_interesting i
        }
        File.read(File.dirname(__FILE__) + '/../data/uninteresting.txt').split("\n").each { |i|
          b.train_uninteresting i
        }
        b
      )
  end
  
  def self.string_to_sentences(string)
    return [] unless string
    @tactful_tokenizer ||= TactfulTokenizer::Model.new
    @tactful_tokenizer.tokenize_text(string)
  end
end
