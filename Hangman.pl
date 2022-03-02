#Name - Rohit Kinha
#Entry Number - 2020CSB1118
#Creating a class named Hangman
package Hangman {

    #sub-routine Welcome to greet the user and provide Instructions
    sub welcome {
        print
"\n**********************************************************************************************************************************\n";
        print
"---------------------------------------------------  Welcome to the Hangman Game  ------------------------------------------------\n";
        print
"||                      Instructions : You have to guess the word correctly to save your friend from being hanged ...             ||  \n";
        print
"+++++++++++++++++++++++++++++++++++++++++++++++++++++++    Have Fun   ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n";
    }

  #Array @words to a sample of words all having lowercase characters and numbers
    @words = (
        "computer",      "radio",        "calculator",    "teacher",
        "bureau",        "police",       "geometry",      "president",
        "subject",       "country",      "enviroment",    "classroom",
        "animals",       "province",     "month",         "politics",
        "puzzle",        "instrument",   "kitchen",       "language",
        "vampire",       "ghost",        "solution",      "service",
        "software",      "virus25",      "security",      "phonenumber",
        "expert",        "website",      "agreement",     "support",
        "compatibility", "advanced",     "search",        "triathlon",
        "immediately",   "encyclopedia", "endurance",     "distance",
        "nature",        "history",      "organization",  "international",
        "championship",  "government",   "popularity",    "thousand",
        "feature",       "wetsuit",      "fitness",       "legendary",
        "variation",     "equal",        "approximately", "segment",
        "priority",      "physics",      "branche",       "science",
        "mathematics",   "lightning",    "dispersion",    "accelerator",
        "detector",      "terminology",  "design",        "operation",
        "foundation",    "application",  "prediction",    "reference",
        "measurement",   "concept",      "perspective",   "overview",
        "position",      "airplane",     "symmetry",      "dimension",
        "toxic",         "algebra",      "illustration",  "classic",
        "verification",  "citation",     "unusual",       "resource",
        "analysis",      "license",      "comedy",        "screenplay",
        "production",    "release",      "emphasis",      "director",
        "trademark",     "vehicle",      "aircraft",      "experiment"
    );

#sub-routine drawHangman to draw the hangman parts according to the number of guess missed
    sub drawHangman {
        my ($misses) = @_;
        if ( $misses == 0 ) {
            print "  +---+ \n";
            print "  |   | \n";
            print "      | \n";
            print "      | \n";
            print "      | \n";
            print "      | \n";
            print " ========= \n";
        }
        elsif ( $misses == 1 ) {
            print "  +---+ \n";
            print "  |   | \n";
            print "  O   | \n";
            print "      | \n";
            print "      | \n";
            print "      | \n";
            print " ========= \n";
        }
        elsif ( $misses == 2 ) {
            print "  +---+ \n";
            print "  |   | \n";
            print "  O   | \n";
            print "  |   | \n";
            print "      | \n";
            print "      | \n";
            print " ========= \n";
        }
        elsif ( $misses == 3 ) {
            print "  +---+ \n";
            print "  |   | \n";
            print "  O   | \n";
            print " /|   | \n";
            print "      | \n";
            print "      | \n";
            print " ========= \n";
        }
        elsif ( $misses == 4 ) {
            print "  +---+ \n";
            print "  |   | \n";
            print "  O   | \n";
            print " /|\\  | \n";
            print "      | \n";
            print "      | \n";
            print " ========= \n";
        }
        elsif ( $misses == 5 ) {
            print "  +---+ \n";
            print "  |   | \n";
            print "  O   | \n";
            print " /|\\  | \n";
            print " /    | \n";
            print "      | \n";
            print " ========= \n";
        }
        elsif ( $misses == 6 ) {
            print "  +---+ \n";
            print "  |   | \n";
            print "  O   | \n";
            print " /|\\  | \n";
            print " / \\  | \n";
            print "      | \n";
            print " ========= \n";
        }
    }

  #sub-routine display_guessed_word to print out the word guessed by user so far
    sub display_guessed_word {
        my (@guessed_words) = @_;
        print "\nYour Word So Far: \n";
        $size_guessed_words = @guessed_words;
        for ( my $i = 0 ; $i < $size_guessed_words ; $i++ ) {
            print $guessed_words [$i] . " ";
        }
        print "\n";

    }

#sub-routine display_incorrect_words to print out the incorrect guesses made by the user so far so that he can make a wise guess this time
    sub display_incorrect_words {
        my (@incorrect_guesses) = @_;
        print "\nIncorrect guesses are : \n";
        $size_incorrect = @incorrect_guesses;
        for ( my $j = 0 ; $j < $size_incorrect ; $j++ ) {
            print $incorrect_guesses [$j] . " ";
        }
        print "\n";
    }

#sub-routine result to check if the guessed word is equal to the word to be guessed or not
    sub result {
        my ($word) = @_;
        my $c;    #character to iterate over the word
        for ( my $i = 0 ; $i < length($word) ; $i++ ) {
            $c = substr( $word, $i, 1 )
              ;    #taking a substring of 1 character from the word
            if ( $c ne $guessed_words[$i]
              ) #comparing the character to each letter of the guessed word, at any stage if this is not equal then returning zero else return 1 meaning the word is guessed correctly
            {
                return 0;
            }
        }
        return 1;
    }

    #sub-routine begin_game to call all method sequentially and taking input
    sub begin_game {
        welcome;    #calling the welcome sub-routine to greet the user
        @guessed_words     = ();    #to store the guessed characters so far
        $saved             = 0;     #to check if the problem if solved or not
        @incorrect_guesses = ();    #to store the incorrect guesses
        my $misses = 0;             #to count the number of misses
        $word = lc @words[ rand( $#words + 1 ) ]
          ; #taking any random word from the @words array and then converting into lowercase
        my $length_of_word = length($word);    #getting the length of the word
        for ( my $i = 0 ; $i < $length_of_word ; $i++ ) {
            $guessed_words[$i] = '_'
              ; #assigning the guessed word with '_' as many times the length of word
        }

#executing a while loop untill the word is guessed or number of tries is less than 7
        while ( !$saved && $misses < 7 ) {

            drawHangman($misses)
              ;    #drawing the hangman according to number of misses
            display_guessed_word(@guessed_words)
              ;    #displaying the guessed word array
            display_incorrect_words(@incorrect_guesses)
              ;    #displaying the incorrect words array

            print
              "\nPlease Enter your guess (A single Alpha-Numeric Character): "
              ; #asking the user to input a single alpha-numeric character (NOTE : if you enter more than one character than only 1st letter will be counted)
            my $char = <>;
            chomp($char);    #to remove the last tarailing newline
            $char = lc substr( $char, 0, 1 )
              ; #converting the input into lower case and taking only the 1st character if the user enters a longer string
            my $findIndex = index( $word, $char )
              ; #checking if the character is present in the word or not by index function which will output the index at which the given character is presented
            $f = 0;    #varible used as flags in various loops
            $j = 0;    #varible used as flags in various loops
            $k = 0;    #varible used as flags in various loops

            if ( $findIndex == -1 ) {

                #checking if the character is already incorrectly guessed or not
                for ( my $i = 0 ; $i < $#incorrect_guesses + 1 ; $i++ ) {
                    if ( $char eq $incorrect_guesses[$i] ) {
                        $f = 1;
                        print "You already guessed $char!\n";
                    }
                }
                if ( $f == 0 ) {

                    #if this is the last miss then printing the word and message
                    if ( $misses == 6 ) {
                        print "\nThe word was : " . $word;

                        print "\nSorry!!! You couldn't save your friend.\n";
                        $misses++;
                    }

#increamenting the wrong guesses and printing the left number of chances and message
                    else {
                        $misses++;
                        $left_chances = 7 - $misses;
                        print
"\nOoops!! Incorrect guess !! Another portion of the body is drawn\n";
                        print "\nYou have got $left_chances chances left\n";
                        push( @incorrect_guesses, $char )
                          ;    #updating the incorrect guessed words array

                    }
                }

            }
            else {
#if the char is present in the word then checking if it is already guessed of not
                for ( my $i = 0 ; $i < length($word) ; $i++ ) {
                    my $alphabet = substr( $word, $i, 1 );
                    if ( $char eq $guessed_words[$i] ) {
                        $k = 1;
                    }

             #if it is not already guessed then updating the guessed words array
                    if ( $char eq $alphabet ) {
                        $j = 1;
                        $guessed_words[$i] = $alphabet;
                    }
                }
                if ( $k == 1 ) {
                    print "You already guessed $char!\n";
                }
                elsif ( $j == 1 && $k == 0 ) {
                    print
"\nYay!!! You got it right this time. Keep going like this, you can save your friend!!!\n";
                }

            }

            #checking if the word is equal to the guessed word
            $saved = result($word);
            if ( $saved == 1 ) {

                print "The word was : " . $word . "\n";
                print
                  "\nHurray!!! You saved your friend from being hanged!!!\n";
            }

        }
    }
}

$play = 1;    #variable to switch if the game is to be played or not
while ( $play == 1 ) {
    $game = Hangman;      #creating an object of Hangman Class
    $game->begin_game;    #calling the begin game sub
    $play       = 0;
    $play_again = -1;
    while ( $play_again == -1 ) {
        print "\nWanna Try Again? Press (y/n) : "
          ;    #asking the user to input whether to play the game again or not
        $try = <>;
        chomp($try);
        if ( $try eq 'y' ) {
            $play_again = 1;
        }
        elsif ( $try eq 'n' ) {
            $play_again = 0;
        }
        else {
            print "\nPlease Enter a valid Input!\n";
        }
    }
    $play = $play_again;    #updating the play variable
}
