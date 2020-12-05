class Trivia

    @@all = [ {"question" => "Who is the NBA coach with the most titles?", 
    "answer" => "Phil Jackson has 11 NBA championships, the most in league history" },
    {"question" => "What NBA player has the most championships?",
    "answer" => "Bill Russel with 11"},
    {"question" => "How many championship rings does Michael Jordan have?",
    "answer" => "Michael Jordan has won 6 championshps"},
    {"question" => "What was Vince Carter's vertical at the NBA combine?",
    "answer" => "Vince recorded a whopping 43 inch standing vertical!"},
    {"question" => "How old is the NBA?",
    "answer" => "The NBA is currently #{Time.now.year - 1946} years old"}

    ]

    def self.grab
        @@all.sample
    end

end

    