require 'test/unit'
require 'shine'
#require 'active_support/testing/assertions'


class ShineTest < Test::Unit::TestCase
  def test_truth
    doc = <<-EOF
Facebook shares have dipped below $29 for the first time since their flotation to a new low.

The shares were launched at $38 less than two weeks ago during its high-profile flotation, which valued the firm at $104bn (£66bn).

Since then, Facebook's shares have lost almost a quarter of their value.

Russia's biggest social network, VKontakte, has now postponed its stock market launch, fearing a repeat of Facebook's problems.

"The IPO of FB [Facebook] destroyed the faith of many private investors in social networks," said chief executive Pavel Durov in a message posted on Twitter.

Facebook shares closed down 9.6% to $28.82, just above its low of $28.78.

One reason for the fall in shares since its initial public offering (IPO) is that Tuesday was the first day that options on Facebook stock began trading.

Options are a form of derivative, that allow bets on the future direction of the stock. It appears that most investors are betting Facebook shares will head lower.

"Facebook's stock market debut is already going down as one of the most troubled of recent years," says BBC technology correspondent Rory Cellan-Jones.

The situation is a remarkable turnaround from recent weeks, when the eight-year-old firm's share sale was over-subscribed.
Lawsuits

The social networking site has transformed the way in which hundreds of millions of people around the world communicate. It is also transforming the way companies advertise to existing and potential customers.

But Facebook's 900 million users helped the company generate just $1bn in profit last year, and there are concerns about its ability to increase profits in the future.

The flotation was disrupted on its first day of trading by technical glitches on the Nasdaq stock exchange. The share price has since slumped amid worries that the company was over-valued by advisers marketing the float.

Now, a group of investors has issued a class-action lawsuit alleging that Facebook revenues were revised down because of a surge in the number of people using mobile devices for apps and connection to websites.

The suit targets Facebook, its founder Mark Zuckerberg and the banks behind the flotation, including lead underwriter Morgan Stanley.

The share sale in New York raised $16bn for Facebook.

Recent reports suggested that Facebook is to launch its own smartphone by next year.
EOF
    result = Shine.shine(doc, :max_length => 388)
    pp [result, result.size]
    assert result.size > 100
    assert result.size < 388
    result = Shine.shine(doc, :max_length => 888)
    pp [result, result.size]
    assert result.size > 100
    assert result.size < 888
    result = Shine.shine(doc, :max_length => 1888)
    pp [result, result.size]
    assert result.size > 100
    assert result.size < 1888
    result = Shine.shine(doc, :max_sentences => 1)
    pp [result, result.size]
    result = Shine.shine(doc, :max_sentences => 2)
    pp [result, result.size]
    result = Shine.shine(doc, :max_sentences => 3)
    pp [result, result.size]
  end
end
