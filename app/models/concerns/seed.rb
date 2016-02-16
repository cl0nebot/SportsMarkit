module Seed
  extend ActiveSupport::Concern
  
  CITIES = ["New York City", "Los Angeles", "Chicago", "Houston", "Philadelphia", "Phoenix", "San Antonio", "San Diego", "Dallas", "San Jose", "Austin", "Jacksonville", "Indianapolis", "San Francisco", "Columbus", "Fort Worth", "Charlotte", "Detroit", "El Paso", "Memphis", "Boston", "Seattle", "Denver", "Washington", "Nashville-Davidson", "Baltimore", "Louisville-Jefferson", "Portland", "Oklahoma City", "Milwaukee", "Las Vegas", "Albuquerque", "Tucson", "Fresno", "Sacramento", "Long Beach", "Kansas-MO", "Mesa", "Virginia Beach", "Atlanta", "Colorado Springs", "Raleigh", "Omaha", "Miami", "Oakland", "Tulsa", "Minneapolis", "Cleveland", "Wichita", "Arlington", "New Orleans", "Bakersfield", "Tampa", "Honolulu", "Anaheim", "Aurora-CO", "Santa Ana", "St. Louis", "Riverside", "Corpus Christi", "Pittsburgh", "Lexington-Fayette", "Anchorage", "Stockton", "Cincinnati", "St. Paul", "Toledo", "Newark", "Greensboro", "Plano", "Henderson", "Lincoln", "Buffalo", "Fort Wayne", "Jersey City", "Chula Vista", "Orlando", "St. Petersburg", "Norfolk", "Chandler", "Laredo", "Madison", "Durham", "Lubbock", "Winston-Salem", "Garland", "Glendale", "Hialeah", "Reno", "Baton Rouge", "Irvine", "Chesapeake", "Irving", "Scottsdale", "North Las Vegas", "Fremont", "Gilbert", "San Bernardino", "Boise", "Birmingham", "Rochester", "Richmond", "Spokane", "Des Moines", "Montgomery", "Modesto", "Fayetteville", "Tacoma", "Shreveport", "Fontana", "Oxnard", "Aurora-IL", "Moreno Valley", "Akron", "Yonkers", "Columbus-GA", "Augusta-Richmond", "Little Rock", "Amarillo", "Mobile", "Huntington Beach", "Glendale", "Grand Rapids", "Salt Lake City", "Tallahassee", "Huntsville", "Worcester", "Knoxville", "Grand Prairie", "Newport News", "Brownsville", "Santa Clarita", "Overland Park", "Providence", "Jackson", "Garden Grove", "Oceanside", "Chattanooga", "Fort Lauderdale", "Rancho Cucamonga", "Santa Rosa", "Port St. Lucie", "Ontario", "Tempe", "Vancouver", "Springfield-MO", "Cape Coral", "Pembroke Pines", "Sioux Falls", "Peoria", "Lancaster", "Elk Grove", "Corona", "Eugene", "Salem", "Palmdale", "Salinas", "Springfield-MA", "Pasadena-TX", "Rockford", "Pomona", "Hayward", "Fort Collins", "Joliet", "Escondido", "Kansas-KS", "Torrance", "Bridgeport", "Alexandria", "Sunnyvale", "Cary", "Lakewood", "Hollywood", "Paterson", "Syracuse", "Naperville", "McKinney", "Mesquite", "Clarksville", "Savannah", "Dayton", "Orange", "Fullerton", "Pasadena", "Hampton", "McAllen", "Killeen", "Warren", "West Valley", "Columbia", "New Haven", "Sterling Heights", "Olathe", "Miramar", "Thousand Oaks", "Frisco", "Cedar Rapids", "Topeka", "Visalia", "Waco", "Belle Glade", "Boca Raton", "Boynton Beach", "Delray Beach", "Greenacres", "Juno Beach", "Jupiter", "Lake Park", "Lake Worth", "Lantana", "Palm Beach", "Palm Beach Gardens", "Pahokee", "Riviera Beach", "South Bay", "Palm Beach", "Royal Palm Beach", "Wellington", "West Palm Beach"]

  GIRL_NAMES = ["Emma", "Olivia", "Sophia", "Isabella","Ava","Mia","Emily","Abigail","Madison","Charlotte","Harper","Sofia","Avery","Elizabeth","Amelia","Evelyn","Ella","Chloe","Victoria","Aubrey","Grace","Zoey","Natalie","Addison","Lillian","Brooklyn","Lily","Hannah","Layla","Scarlett","Aria","Zoe","Samantha","Anna","Leah","Audrey","Ariana","Allison","Savannah","Arianna","Camila","Penelope","Gabriella","Claire","Aaliyah","Sadie","Riley","Skylar","Nora","Sarah","Hailey","Kaylee","Paisley","Kennedy","Ellie","Peyton","Annabelle","Caroline","Madelyn","Serenity","Aubree","Lucy","Alexa","Alexis","Nevaeh","Stella","Violet","Genesis","Mackenzie","Bella","Autumn","Mila","Kylie","Maya","Piper","Alyssa","Taylor","Eleanor","Melanie","Naomi","Faith","Eva","Katherine","Lydia","Brianna","Julia","Ashley","Khloe","Madeline","Ruby","Sophie","Alexandra","London","Lauren","Gianna","Isabelle","Alice","Vivian","Hadley","Jasmine","Morgan","Kayla","Cora","Bailey","Kimberly","Reagan","Hazel","Clara","Sydney","Trinity","Natalia","Valentina","Rylee","Jocelyn","Maria","Aurora","Eliana","Brielle","Liliana","Mary","Elena","Molly","Makayla","Lilly","Andrea","Quinn","Jordyn","Adalynn","Nicole","Delilah","Kendall","Kinsley","Ariel","Payton","Paige","Mariah","Brooke","Willow","Jade","Lyla","Mya","Ximena","Luna","Isabel","Mckenzie","Ivy","Josephine","Amy","Laila","Isla","Eden","Adalyn","Angelina","Londyn","Rachel","Melody","Juliana","Kaitlyn","Brooklynn","Destiny","Emery","Gracie","Norah","Emilia","Reese","Elise","Sara","Aliyah","Margaret","Catherine","Vanessa","Katelyn","Gabrielle","Arabella","Valeria","Valerie","Adriana","Everly","Jessica","Daisy","Makenzie","Summer","Lila","Rebecca","Julianna","Callie","Michelle","Ryleigh","Presley","Alaina","Angela","Alina","Harmony","Rose","Athena","Emerson","Adelyn","Alana","Hayden","Izabella","Cali","Marley","Esther","Fiona","Stephanie","Cecilia","Kate","Kinley","Jayla","Genevieve","Alexandria","Eliza","Kylee","Alivia","Giselle","Arya","Alayna","Leilani","Adeline","Jennifer","Tessa","Ana","Finley","Melissa","Daniela","Aniyah","Daleyza","Keira","Charlie","Lucia","Hope","Gabriela","Mckenna","Brynlee","Parker","Lola","Amaya","Miranda","Maggie","Anastasia","Leila","Lexi","Georgia","Kenzie","Iris","Jacqueline","Jordan","Cassidy","Vivienne","Camille","Noelle","Adrianna","Teagan","Josie","Juliette","Annabella","Allie","Juliet","Kendra","Sienna","Brynn","Kali","Maci","Danielle","Haley","Jenna","Raelynn","Delaney","Paris","Alexia","Lyric","Gemma","Lilliana","Chelsea","Angel","Evangeline","Ayla","Kayleigh","Lena","Katie","Elaina","Olive","Madeleine","Makenna","Dakota","Elsa","Nova","Nadia","Alison","Kaydence","Journey","Jada","Kathryn","Shelby","Nina","Elliana","Diana","Phoebe","Alessandra","Eloise","Nyla","Skyler","Madilyn","Adelynn","Miriam","Ashlyn","Amiyah","Megan","Amber","Rosalie","Annie","Lilah","Charlee","Amanda","Ruth","Adelaide","June","Laura","Daniella","Mikayla","Raegan","Jane","Ashlynn","Kelsey","Erin","Christina","Joanna","Fatima","Allyson","Talia","Mariana","Sabrina","Haven","Ainsley","Cadence","Elsie","Leslie","Heaven","Arielle","Maddison","Alicia","Briella","Lucille","Sawyer","Malia","Selena","Heidi","Kyleigh","Harley","Kira","Lana","Sierra","Kiara","Paislee","Alondra","Daphne","Carly","Jaylah","Kyla","Bianca","Baylee","Cheyenne","Macy","Camilla","Catalina","Gia","Vera","Skye","Aylin","Sloane","Myla","Yaretzi","Giuliana","Macie","Veronica","Esmeralda","Lia","Averie","Addyson","Kamryn","Mckinley","Ada","Carmen","Mallory","Jillian","Ariella","Rylie","Sage","Abby","Scarlet","Logan","Tatum","Bethany","Dylan","Elle","Jazmin","Aspen","Camryn","Malaysia","Haylee","Nayeli","Gracelyn","Kamila","Helen","Marilyn","April","Carolina","Amina","Julie","Raelyn","Blakely","Rowan","Angelique","Miracle","Emely","Jayleen","Kennedi","Amira","Briana","Gwendolyn","Justice","Zara","Aleah","Itzel","Bristol","Francesca","Emersyn","Aubrie","Karina","Nylah","Kelly","Anaya","Maliyah","Evelynn","Ember","Melany","Angelica","Jimena","Madelynn","Kassidy","Tiffany","Kara","Jazmine","Jayda","Dahlia","Alejandra","Sarai","Annabel","Holly","Janelle","Braelyn","Gracelynn","River","Viviana","Serena","Brittany","Annalise","Brinley","Madisyn","Eve","Cataleya","Joy","Caitlyn","Anabelle","Emmalyn","Journee","Celeste","Brylee","Luciana","Marlee","Savanna","Anya","Marissa","Jazlyn","Zuri","Kailey","Crystal","Michaela","Lorelei","Guadalupe","Madilynn","Maeve","Hanna","Priscilla","Kyra","Lacey","Nia","Charley","Jamie","Juniper","Cynthia","Karen","Sylvia","Phoenix","Aleena","Caitlin","Felicity","Elisa","Julissa","Rebekah","Evie","Helena","Imani","Karla","Millie","Lilian","Raven","Harlow","Leia","Ryan","Kailyn","Lillie","Amara","Kadence","Lauryn","Cassandra","Kaylie","Madalyn","Anika","Hayley","Bria","Colette","Henley","Amari","Regina","Alanna","Azalea","Fernanda","Jaliyah","Anabella","Adelina","Lilyana","Skyla","Addisyn","Zariah","Bridget","Braylee","Monica","Jayden","Leighton","Gloria","Johanna","Addilyn","Danna","Selah","Aryanna","Kaylin","Aniya","Willa","Angie","Kaia","Kaliyah","Anne","Tiana","Charleigh","Winter","Danica","Alayah","Aisha","Bailee","Kenley","Aileen","Lexie","Janiyah","Braelynn","Liberty","Katelynn","Mariam","Sasha","Lindsey","Montserrat","Cecelia","Mikaela","Kaelyn","Rosemary","Annika","Tatiana","Cameron","Marie","Dallas","Virginia","Liana","Matilda","Freya","Lainey","Hallie","Jessie","Audrina","Blake","Hattie","Monserrat","Kiera","Laylah","Greta","Alyson","Emilee","Maryam","Melina","Dayana","Jaelynn","Beatrice","Frances","Elisabeth","Saige","Kensley","Meredith","Aranza","Rosa","Shiloh","Charli","Elyse","Alani","Mira","Lylah","Linda","Whitney","Alena","Jaycee","Joselyn","Ansley","Kynlee","Miah","Tenley","Breanna","Emelia","Maia","Edith","Pearl","Anahi","Coraline","Samara","Demi","Chanel","Kimber","Lilith","Malaya","Jemma","Myra","Bryanna","Laney","Jaelyn","Kaylynn","Kallie","Natasha","Nathalie","Perla","Amani","Lilianna","Madalynn","Blair","Elianna","Karsyn","Lindsay","Elaine","Dulce","Ellen","Erica","Maisie","Renata","Kiley","Marina","Remi","Emmy","Ivanna","Amirah","Livia","Amelie","Irene","Mabel","Milan","Armani","Cara","Ciara","Kathleen","Jaylynn","Caylee","Lea","Erika","Paola","Alma","Courtney","Mae","Kassandra","Maleah","Remington","Leyla","Mina","Ariah","Christine","Jasmin","Kora","Chaya","Karlee","Lailah","Mara","Jaylee","Raquel","Siena","Lennon","Desiree","Hadassah","Kenya","Aliana","Wren","Amiya","Isis","Zaniyah","Avah","Amia","Cindy","Eileen","Kayden","Madyson","Celine","Aryana","Everleigh","Isabela","Reyna","Teresa","Jolene","Marjorie","Myah","Clare","Claudia","Leanna","Noemi","Corinne","Simone","Alia","Brenda","Dorothy","Emilie","Elin","Tori","Martha","Ally","Arely","Leona","Patricia","Sky","Thalia","Carolyn","Emory","Nataly","Paityn","Shayla","Averi","Jazlynn","Margot","Lisa","Lizbeth","Nancy","Deborah","Ivory","Khaleesi","Elliot","Meadow","Yareli","Farrah","Milania","Janessa","Milana","Zoie","Adele","Clarissa","Hunter","Lina","Oakley","Sariah","Emmalynn","Galilea","Hailee","Halle","Sutton","Giana","Thea","Denise","Naya","Kristina","Liv","Nathaly","Wendy","Aubrielle","Brenna","Carter","Danika","Monroe","Celia","Dana","Jolie","Taliyah","Casey","Miley","Yamileth","Jaylene","Saylor","Joyce","Milena","Zariyah","Sandra","Ariadne","Aviana","Mollie","Cherish","Alaya","Asia","Nola","Penny","Dixie","Marisol","Adrienne","Rylan","Kori","Kristen","Aimee","Esme","Laurel","Aliza","Roselyn","Sloan","Lorelai","Jenny","Katalina","Lara","Amya","Ayleen","Aubri","Ariya","Carlee","Iliana","Magnolia","Aurelia","Elliott","Evalyn","Natalee","Rayna","Heather","Collins","Estrella","Rory","Hana","Kenna","Jordynn","Rosie","Aiyana","America","Angeline","Janiya","Jessa","Tegan","Susan","Emmalee","Taryn","Temperance","Alissa","Kenia","Abbigail","Briley","Kailee","Zaria","Chana","Lillianna","Barbara","Carla","Aliya","Bonnie","Keyla","Marianna","Paloma","Jewel","Joslyn","Saniyah","Audriana","Giovanna","Hadleigh","Mckayla","Jaida","Salma","Sharon","Emmaline","Kimora","Wynter","Avianna","Amalia","Karlie","Kaidence","Kairi","Libby","Sherlyn","Diamond","Holland","Zendaya","Mariyah","Zainab","Alisha","Ayanna","Ellison","Harlee","Lilyanna","Bryleigh","Julianne","Kaleigh","Miya","Yasmin","Anniston","Estelle","Emmeline","Faye","Kiana","Anabel","Zion","Tara","Astrid","Emerie","Sidney","Zahra","Jaylin","Kinslee","Tabitha","Aubriella","Addilynn","Alyvia","Hadlee","Ingrid","Lilia","Macey","Azaria","Kaitlynn","Neriah","Annabell","Ariyah","Janae","Kaiya","Reina","Rivka","Alisa","Marleigh","Alisson","Maliah","Mercy","Noa","Scarlette","Clementine","Frida","Ann","Sonia","Alannah","Avalynn","Dalia","Ayva","Stevie","Judith","Paulina","Azariah","Estella","Remy","Gwen","Mattie","Milani","Raina","Julieta","Renee","Lesly","Abrielle","Bryn","Carlie","Riya","Karter","Abril","Aubrianna","Jocelynn","Kylah","Louisa","Pyper","Antonia","Magdalena","Moriah","Ryann","Tamia","Kailani","Landry","Aya","Ireland","Mercedes","Rosalyn","Alaysia","Annalee","Patience","Aanya","Paula","Samiyah","Yaritza","Cordelia","Micah","Nala","Belen","Cambria","Natalya","Kaelynn","Kai"]

  BOY_NAMES = ["Noah", "Liam", "Mason", "Jacob", "William", "Ethan", "Michael", "Alexander", "James", "Daniel", "Elijah", "Benjamin", "Logan", "Aiden", "Jayden", "Matthew", "Jackson", "David", "Lucas", "Joseph", "Anthony", "Andrew", "Samuel", "Gabriel", "Joshua", "John", "Carter", "Luke", "Dylan", "Christopher", "Isaac", "Oliver", "Henry", "Sebastian", "Caleb", "Owen", "Ryan", "Nathan", "Wyatt", "Hunter", "Jack", "Christian", "Landon", "Jonathan", "Levi", "Jaxon", "Julian", "Isaiah", "Eli", "Aaron", "Charles", "Connor", "Cameron", "Thomas", "Jordan", "Jeremiah", "Nicholas", "Evan", "Adrian", "Gavin", "Robert", "Brayden", "Grayson", "Josiah", "Colton", "Austin", "Angel", "Jace", "Dominic", "Kevin", "Brandon", "Tyler", "Parker", "Ayden", "Jason", "Jose", "Ian", "Chase", "Adam", "Hudson", "Nolan", "Zachary", "Easton", "Blake", "Jaxson", "Cooper", "Lincoln", "Xavier", "Bentley", "Kayden", "Carson", "Brody", "Asher", "Nathaniel", "Ryder", "Justin", "Leo", "Juan", "Luis", "Camden", "Tristan", "Damian", "Elias", "Vincent", "Jase", "Mateo", "Maxwell", "Miles", "Micah", "Sawyer", "Jesus", "Max", "Roman", "Leonardo", "Santiago", "Cole", "Carlos", "Bryson", "Ezra", "Brantley", "Braxton", "Declan", "Eric", "Kaiden", "Giovanni", "Theodore", "Harrison", "Alex", "Diego", "Wesley", "Bryce", "Ivan", "Greyson", "George", "Timothy", "Weston", "Silas", "Jonah", "Antonio", "Colin", "Richard", "Hayden", "Ashton", "Steven", "Axel", "Miguel", "Kaleb", "Bryan", "Preston", "Jayce", "Ryker", "Victor", "Patrick", "Joel", "Grant", "Emmett", "Alejandro", "Marcus", "Jameson", "Edward", "Kingston", "Jude", "Maddox", "Abel", "Emmanuel", "Bennett", "Everett", "Brian", "Jeremy", "Alan", "Kaden", "Jaden", "Riley", "Jesse", "King", "Tucker", "Kai", "Kyle", "Malachi", "Abraham", "Ezekiel", "Calvin", "Oscar", "Bradley", "Luca", "Avery", "Aidan", "Zayden", "Mark", "Jake", "Kenneth", "Maximus", "Sean", "Karter", "Brady", "Nicolas", "Cayden", "Caden", "Graham", "Jayceon", "Paul", "Gage", "Corbin", "Peter", "Derek", "Maverick", "Jorge", "Tanner", "Jax", "Peyton", "Xander", "Amir", "Gael", "Omar", "Iker", "Javier", "Elliot", "Jasper", "Rylan", "Cody", "Dean", "Andres", "Collin", "Zane", "Charlie", "Myles", "Lorenzo", "Beau", "Conner", "Lukas", "Simon", "Francisco", "Elliott", "Finn", "Gunner", "Garrett", "Jaiden", "Keegan", "Rowan", "Israel", "Griffin", "August", "Judah", "Beckett", "Brooks", "Zander", "Spencer", "Chance", "Damien", "Seth", "Waylon", "Travis", "Devin", "Emiliano", "Zion", "Ricardo", "Erick", "Stephen", "Reid", "Paxton", "Eduardo", "Martin", "Fernando", "Raymond", "Manuel", "Jeffrey", "Felix", "Dallas", "Josue", "Mario", "Clayton", "Caiden", "Cristian", "Troy", "Cash", "Trevor", "Shane", "Kameron", "Cesar", "Emilio", "Andy", "Tyson", "Andre", "Donovan", "Titus", "Knox", "River", "Kyler", "Louis", "Cruz", "Hector", "Holden", "Rafael", "Landen", "Lane", "Jared", "Edwin", "Messiah", "Johnny", "Edgar", "Johnathan", "Alexis", "Archer", "Anderson", "Trenton", "Arthur", "Sergio", "Marco", "Julius", "Dominick", "Milo", "Dalton", "Remington", "Dante", "Angelo", "Gregory", "Reed", "Jaylen", "Marshall", "Dawson", "Leon", "Drew", "Shawn", "Emerson", "Fabian", "Joaquin", "Walker", "Erik", "Desmond", "Karson", "Emanuel", "Jett", "Ali", "Kendrick", "Aden", "Frank", "Walter", "Rhett", "Colt", "Amari", "Romeo", "Cohen", "Roberto", "Maximiliano", "Grady", "Barrett", "Zaiden", "Drake", "Gideon", "Major", "Brendan", "Skyler", "Derrick", "Pedro", "Phoenix", "Noel", "Ruben", "Braden", "Nehemiah", "Dakota", "Cade", "Kamden", "Quinn", "Nash", "Kason", "Ronan", "Allen", "Porter", "Enzo", "Atticus", "Kash", "Jay", "Adan", "Finley", "Matteo", "Malik", "Abram", "Braylon", "Ace", "Solomon", "Gunnar", "Clark", "Orion", "Ismael", "Kellan", "Brennan", "Corey", "Tate", "Philip", "Thiago", "Phillip", "Esteban", "Jayson", "Dexter", "Jensen", "Pablo", "Ronald", "Dillon", "Muhammad", "Armando", "Bruce", "Gerardo", "Brycen", "Marcos", "Kade", "Kolton", "Damon", "Braylen", "Russell", "Leland", "Milan", "Prince", "Gannon", "Enrique", "Keith", "Rory", "Brock", "Donald", "Tobias", "Chandler", "Deacon", "Cason", "Raul", "Ty", "Scott", "Landyn", "Mohamed", "Colby", "Danny", "Leonel", "Kayson", "Warren", "Adriel", "Dustin", "Taylor", "Albert", "Ryland", "Hugo", "Keaton", "Jamison", "Ari", "Malcolm", "Ellis", "Kellen", "Maximilian", "Davis", "Saul", "Tony", "Rocco", "Zachariah", "Jerry", "Julio", "Franklin", "Arjun", "Ibrahim", "Nico", "Jaxton", "Jakob", "Izaiah", "Moises", "Cyrus", "Lawrence", "Sullivan", "Finnegan", "Khalil", "Mathew", "Case", "Jaime", "Alec", "Pierce", "Quentin", "Kasen", "Darius", "Colten", "Royce", "Odin", "Kane", "Francis", "Raiden", "Trey", "Daxton", "Gustavo", "Rhys", "Alijah", "Lawson", "Beckham", "Moses", "Rodrigo", "Armani", "Uriel", "Dennis", "Marvin", "Harvey", "Kian", "Raylan", "Darren", "Frederick", "Mohammed", "Trent", "Jonas", "Zayne", "Callen", "Matias", "Mitchell", "Kyrie", "Uriah", "Tristen", "Sterling", "Theo", "Larry", "Randy", "Korbin", "Alberto", "Chris", "Gianni", "Killian", "Princeton", "Arturo", "Ricky", "Malakai", "Aarav", "Asa", "Jimmy", "Alfredo", "Alonzo", "Benson", "Braydon", "Devon", "Curtis", "Casey", "Justice", "Roy", "Sam", "Legend", "Dorian", "Nikolai", "Kobe", "Winston", "Arlo", "Reece", "Lance", "Wade", "Cannon", "Augustus", "Hayes", "Hendrix", "Isaias", "Neymar", "Ahmed", "Jaxen", "Nasir", "Brayan", "Issac", "Ronin", "Talon", "Boston", "Moshe", "Orlando", "Vihaan", "Gary", "Bowen", "Luka", "Nikolas", "Yahir", "Joe", "Leonidas", "Quinton", "Luciano", "Ezequiel", "Ayaan", "Ahmad", "Jalen", "Royal", "Jamari", "Noe", "Kieran", "Mauricio", "Conor", "Johan", "Matthias", "Bryant", "Mathias", "Maurice", "Roger", "Lennox", "Nathanael", "Nixon", "Mohammad", "Yusuf", "Eddie", "Kristopher", "Tatum", "Jacoby", "Wilson", "Alvin", "Raphael", "Lewis", "Douglas", "Mekhi", "Salvador", "Eden", "Hank", "Cullen", "Dax", "Toby", "Rayan", "Emmitt", "Lucian", "Jefferson", "Casen", "London", "Roland", "Carl", "Crosby", "Bodhi", "Dominik", "Niko", "Zackary", "Deandre", "Hamza", "Remy", "Quincy", "Alessandro", "Sincere", "Dane", "Terry", "Otto", "Samson", "Madden", "Jasiah", "Layne", "Santino", "Rohan", "Abdullah", "Brentley", "Marc", "Skylar", "Bo", "Kyson", "Soren", "Harley", "Nelson", "Layton", "Payton", "Aldo", "Atlas", "Ramon", "Reese", "Conrad", "Morgan", "Ernesto", "Byron", "Carmelo", "Sage", "Neil", "Kristian", "Oakley", "Tomas", "Flynn", "Lionel", "Kylan", "Leonard", "Rex", "Brett", "Jeffery", "Duke", "Sylas", "Callan", "Tripp", "Bruno", "Zechariah", "Melvin", "Branson", "Blaine", "Jon", "Julien", "Arian", "Guillermo", "Zain", "Rayden", "Brodie", "Crew", "Memphis", "Kelvin", "Stanley", "Joey", "Emery", "Terrance", "Channing", "Edison", "Lennon", "Demetrius", "Amos", "Cayson", "Rodney", "Cory", "Elian", "Xzavier", "Bronson", "Bentlee", "Lee", "Dayton", "Chad", "Cassius", "Jagger", "Fletcher", "Omari", "Alonso", "Yosef", "Westin", "Brenden", "Makai", "Felipe", "Harry", "Alden", "Maxim", "Nickolas", "Davion", "Forrest", "Allan", "Enoch", "Willie", "Ben", "Terrence", "Tommy", "Adonis", "Cain", "Harper", "Callum", "Jermaine", "Kody", "Thaddeus", "Ray", "Kamari", "Aydin", "Zeke", "Markus", "Ariel", "Elisha", "Lucca", "Marcelo", "Shaun", "Aryan", "Vicente", "Aron", "Keagan", "Marlon", "Langston", "Ulises", "Anders", "Kareem", "Bobby", "Davian", "Kendall", "Ronnie", "Jadiel", "Samir", "Alexzander", "Hassan", "Kingsley", "Axton", "Trace", "Will", "Jamal", "Valentino", "Yousef", "Brecken", "Fisher", "Giovani", "Kaysen", "Maxton", "Mayson", "Van", "Hezekiah", "Blaze", "Kolten", "Misael", "Javon", "Kolby", "Rogelio", "Ares", "Jedidiah", "Bode", "Leandro", "Cedric", "Jamie", "Rowen", "Urijah", "Wayne", "Eugene", "Kole", "Camron", "Darian", "Billy", "Kase", "Rene", "Duncan", "Adrien", "Alfred", "Maison", "Apollo", "Braeden", "Mack", "Clyde", "Reginald", "Anson", "Jerome", "Ishaan", "Jessie", "Javion", "Micheal", "Vincenzo", "Camdyn", "Gauge", "Keenan", "Gerald", "Franco", "Junior", "Justus", "Jamir", "Marley", "Terrell", "Giancarlo", "Braiden", "Brantlee", "Draven", "Titan", "Harold", "Landry", "Zayn", "Briggs", "Kyree", "Chaim", "Dilan", "Joziah", "Marquis", "Jonathon", "Azariah", "Kenny", "Amare", "Brent", "Clay", "Stetson", "Tyrone", "Blaise", "Dariel", "Lamar", "Reuben", "Alfonso", "Axl", "Stefan", "Finnley", "Marcel", "Jaydon", "Kalel", "Triston", "Darrell", "Steve", "Abdiel", "Lyric", "Gibson", "Thatcher", "Henrik", "Jadon", "Jairo", "Rudy", "Castiel", "Emory", "Hugh", "Konnor", "Graysen", "Cristiano", "Deshawn", "Eliezer", "Kamdyn", "Miller", "Rylee", "Tristian", "Agustin", "Ernest", "Dwayne", "Dimitri", "Ford", "Rey", "Zavier", "Arnav", "Santana", "Vance", "Jamarion", "Ramiro", "Sonny", "Brice", "Leighton", "Gilbert", "Jordyn", "Kaeden", "Anton", "Coen", "Salvatore", "Seamus", "Zaire", "Aaden", "Chevy", "Lachlan", "Rolando", "Aydan", "Darwin", "Randall", "Santos", "Yael", "Grey", "Kohen", "Rashad", "Jayse", "Lochlan", "Mustafa", "Johnathon", "Kannon", "Konner", "Jovani", "Maximo", "Alvaro", "Clinton", "Aidyn", "Kymani", "Davin", "Jordy", "Ephraim", "Frankie", "Heath", "Houston", "Kamron", "Craig", "Cristopher", "Gordon", "Harlan", "Turner", "Vaughn", "Vivaan", "Ameer", "Gavyn", "Gino", "Jovanni", "Benton", "Rodolfo", "Dominique", "Jaycob", "Jericho", "Augustine", "Coleman", "Dash", "Eliseo", "Khalid", "Quintin", "Makhi", "Zaid", "Anakin", "Baylor", "Emmet", "Judson", "Truman", "Camilo", "Efrain", "Semaj", "Camren", "Damari", "Kamryn", "Deangelo", "Giovanny", "Mike", "Dario", "Kale", "Broderick", "Jayvion", "Kaison", "Koen", "Magnus", "Darien", "Teagan", "Valentin", "Bodie", "Brayson", "Chace", "Kylen", "Yehuda", "Bridger", "Howard", "Maddux", "Osvaldo", "Rocky", "Ayan", "Boden", "Foster", "Jair", "Reyansh", "Tyree", "Ean", "Leif", "Reagan", "Rylen"]

  LAST_NAMES = ["Smith" , "Johnson" , "Williams" , "Brown" , "Jones" , "Miller" , "Davis" , "Garcia" , "Rodriguez" , "Wilson" , "Martinez" , "Anderson" , "Taylor" , "Thomas" , "Hernandez" , "Moore" , "Martin" , "Jackson" , "Thompson" , "White" , "Lopez" , "Lee" , "Gonzalez" , "Harris" , "Clark" , "Lewis" , "Robinson" , "Walker" , "Perez" , "Hall" , "Young" , "Allen" , "Sanchez" , "Wright" , "King" , "Scott" , "Green" , "Baker" , "Adams" , "Nelson" , "Hill" , "Ramirez" , "Campbell" , "Mitchell" , "Roberts" , "Carter" , "Phillips" , "Evans" , "Turner" , "Torres" , "Parker" , "Collins" , "Edwards" , "Stewart" , "Flores" , "Morris" , "Nguyen" , "Murphy" , "Rivera" , "Cook" , "Rogers" , "Morgan" , "Peterson" , "Cooper" , "Reed" , "Bailey" , "Bell" , "Gomez" , "Kelly" , "Howard" , "Ward" , "Cox" , "Diaz" , "Richardson" , "Wood" , "Watson" , "Brooks" , "Bennett" , "Gray" , "James" , "Reyes" , "Cruz" , "Hughes" , "Price" , "Myers" , "Long" , "Foster" , "Sanders" , "Ross" , "Morales" , "Powell" , "Sullivan" , "Russell" , "Ortiz" , "Jenkins" , "Gutierrez" , "Perry" , "Butler" , "Barnes" , "Fisher" , "Henderson" , "Coleman" , "Simmons" , "Patterson" , "Jordan" , "Reynolds" , "Hamilton" , "Graham" , "Kim" , "Gonzales" , "Alexander" , "Ramos" , "Wallace" , "Griffin" , "West" , "Cole" , "Hayes" , "Chavez" , "Gibson" , "Bryant" , "Ellis" , "Stevens" , "Murray" , "Ford" , "Marshall" , "Owens" , "Mcdonald" , "Harrison" , "Ruiz" , "Kennedy" , "Wells" , "Alvarez" , "Woods" , "Mendoza" , "Castillo" , "Olson" , "Webb" , "Washington" , "Tucker" , "Freeman" , "Burns" , "Henry" , "Vasquez" , "Snyder" , "Simpson" , "Crawford" , "Jimenez" , "Porter" , "Mason" , "Shaw" , "Gordon" , "Wagner" , "Hunter" , "Romero" , "Hicks" , "Dixon" , "Hunt" , "Palmer" , "Robertson" , "Black" , "Holmes" , "Stone" , "Meyer" , "Boyd" , "Mills" , "Warren" , "Fox" , "Rose" , "Rice" , "Moreno" , "Schmidt" , "Patel" , "Ferguson" , "Nichols" , "Herrera" , "Medina" , "Ryan" , "Fernandez" , "Weaver" , "Daniels" , "Stephens" , "Gardner" , "Payne" , "Kelley" , "Dunn" , "Pierce" , "Arnold" , "Tran" , "Spencer" , "Peters" , "Hawkins" , "Grant" , "Hansen" , "Castro" , "Hoffman" , "Hart" , "Elliott" , "Cunningham" , "Knight" , "Bradley" , "Carroll" , "Hudson" , "Duncan" , "Armstrong" , "Berry" , "Andrews" , "Johnston" , "Ray" , "Lane" , "Riley" , "Carpenter" , "Perkins" , "Aguilar" , "Silva" , "Richards" , "Willis" , "Matthews" , "Chapman" , "Lawrence" , "Garza" , "Vargas" , "Watkins" , "Wheeler" , "Larson" , "Carlson" , "Harper" , "George" , "Greene" , "Burke" , "Guzman" , "Morrison" , "Munoz" , "Jacobs" , "Obrien" , "Lawson" , "Franklin" , "Lynch" , "Bishop" , "Carr" , "Salazar" , "Austin" , "Mendez" , "Gilbert" , "Jensen" , "Williamson" , "Montgomery" , "Harvey" , "Oliver" , "Howell" , "Dean" , "Hanson" , "Weber" , "Garrett" , "Sims" , "Burton" , "Fuller" , "Soto" , "Mccoy" , "Welch" , "Chen" , "Schultz" , "Walters" , "Reid" , "Fields" , "Walsh" , "Little" , "Fowler" , "Bowman" , "Davidson" , "May" , "Day" , "Schneider" , "Newman" , "Brewer" , "Lucas" , "Holland" , "Wong" , "Banks" , "Santos" , "Curtis" , "Pearson" , "Delgado" , "Valdez" , "Pena" , "Rios" , "Douglas" , "Sandoval" , "Barrett" , "Hopkins" , "Keller" , "Guerrero" , "Stanley" , "Bates" , "Alvarado" , "Beck" , "Ortega" , "Wade" , "Estrada" , "Contreras" , "Barnett" , "Caldwell" , "Santiago" , "Lambert" , "Powers" , "Chambers" , "Nunez" , "Craig" , "Leonard" , "Lowe" , "Rhodes" , "Byrd" , "Gregory" , "Shelton" , "Frazier" , "Becker" , "Maldonado" , "Fleming" , "Vega" , "Sutton" , "Cohen" , "Jennings" , "Parks" , "Mcdaniel" , "Watts" , "Barker" , "Norris" , "Vaughn" , "Vazquez" , "Holt" , "Schwartz" , "Steele" , "Benson" , "Neal" , "Dominguez" , "Horton" , "Terry" , "Wolfe" , "Hale" , "Lyons" , "Graves" , "Haynes" , "Miles" , "Park" , "Warner" , "Padilla" , "Bush" , "Thornton" , "Mccarthy" , "Mann" , "Zimmerman" , "Erickson" , "Fletcher" , "Mckinney" , "Page" , "Dawson" , "Joseph" , "Marquez" , "Reeves" , "Klein" , "Espinoza" , "Baldwin" , "Moran" , "Love" , "Robbins" , "Higgins" , "Ball" , "Cortez" , "Le" , "Griffith" , "Bowen" , "Sharp" , "Cummings" , "Ramsey" , "Hardy" , "Swanson" , "Barber" , "Acosta" , "Luna" , "Chandler" , "Blair" , "Daniel" , "Cross" , "Simon" , "Dennis" , "Oconnor" , "Quinn" , "Gross" , "Navarro" , "Moss" , "Fitzgerald" , "Doyle" , "Mclaughlin" , "Rojas" , "Rodgers" , "Stevenson" , "Singh" , "Yang" , "Figueroa" , "Harmon" , "Newton" , "Paul" , "Manning" , "Garner" , "Mcgee" , "Reese" , "Francis" , "Burgess" , "Adkins" , "Goodman" , "Curry" , "Brady" , "Christensen" , "Potter" , "Walton" , "Goodwin" , "Mullins" , "Molina" , "Webster" , "Fischer" , "Campos" , "Avila" , "Sherman" , "Todd" , "Chang" , "Blake" , "Malone" , "Wolf" , "Hodges" , "Juarez" , "Gill" , "Farmer" , "Hines" , "Gallagher" , "Duran" , "Hubbard" , "Cannon" , "Miranda" , "Wang" , "Saunders" , "Tate" , "Mack" , "Hammond" , "Carrillo" , "Townsend" , "Wise" , "Ingram" , "Barton" , "Mejia" , "Ayala" , "Schroeder" , "Hampton" , "Rowe" , "Parsons" , "Frank" , "Waters" , "Strickland" , "Osborne" , "Maxwell" , "Chan" , "Deleon" , "Norman" , "Harrington" , "Casey" , "Patton" , "Logan" , "Bowers" , "Mueller" , "Glover" , "Floyd" , "Hartman" , "Buchanan" , "Cobb" , "French" , "Kramer" , "Mccormick" , "Clarke" , "Tyler" , "Gibbs" , "Moody" , "Conner" , "Sparks" , "Mcguire" , "Leon" , "Bauer" , "Norton" , "Pope" , "Flynn" , "Hogan" , "Robles" , "Salinas" , "Yates" , "Lindsey" , "Lloyd" , "Marsh" , "Mcbride" , "Owen" , "Solis" , "Pham" , "Lang" , "Pratt" , "Lara" , "Brock" , "Ballard" , "Trujillo" , "Shaffer" , "Drake" , "Roman" , "Aguirre" , "Morton" , "Stokes" , "Lamb" , "Pacheco" , "Patrick" , "Cochran" , "Shepherd" , "Cain" , "Burnett" , "Hess" , "Li" , "Cervantes" , "Olsen" , "Briggs" , "Ochoa" , "Cabrera" , "Velasquez" , "Montoya" , "Roth" , "Meyers" , "Cardenas" , "Fuentes" , "Weiss" , "Hoover" , "Wilkins" , "Nicholson" , "Underwood" , "Short" , "Carson" , "Morrow" , "Colon" , "Holloway" , "Summers" , "Bryan" , "Petersen" , "Mckenzie" , "Serrano" , "Wilcox" , "Carey" , "Clayton" , "Poole" , "Calderon" , "Gallegos" , "Greer" , "Rivas" , "Guerra" , "Decker" , "Collier" , "Wall" , "Whitaker" , "Bass" , "Flowers" , "Davenport" , "Conley" , "Houston" , "Huff" , "Copeland" , "Hood" , "Monroe" , "Massey" , "Roberson" , "Combs" , "Franco" , "Larsen" , "Pittman" , "Randall" , "Skinner" , "Wilkinson" , "Kirby" , "Cameron" , "Bridges" , "Anthony" , "Richard" , "Kirk" , "Bruce" , "Singleton" , "Mathis" , "Bradford" , "Boone" , "Abbott" , "Charles" , "Allison" , "Sweeney" , "Atkinson" , "Horn" , "Jefferson" , "Rosales" , "York" , "Christian" , "Phelps" , "Farrell" , "Castaneda" , "Nash" , "Dickerson" , "Bond" , "Wyatt" , "Foley" , "Chase" , "Gates" , "Vincent" , "Mathews" , "Hodge" , "Garrison" , "Trevino" , "Villarreal" , "Heath" , "Dalton" , "Valencia" , "Callahan" , "Hensley" , "Atkins" , "Huffman" , "Roy" , "Boyer" , "Shields" , "Lin" , "Hancock" , "Grimes" , "Glenn" , "Cline" , "Delacruz" , "Camacho" , "Dillon" , "Parrish" , "Oneill" , "Melton" , "Booth" , "Kane" , "Berg" , "Harrell" , "Pitts" , "Savage" , "Wiggins" , "Brennan" , "Salas" , "Marks" , "Russo" , "Sawyer" , "Baxter" , "Golden" , "Hutchinson" , "Liu" , "Walter" , "Mcdowell" , "Wiley" , "Rich" , "Humphrey" , "Johns" , "Koch" , "Suarez" , "Hobbs" , "Beard" , "Gilmore" , "Ibarra" , "Keith" , "Macias" , "Khan" , "Andrade" , "Ware" , "Stephenson" , "Henson" , "Wilkerson" , "Dyer" , "Mcclure" , "Blackwell" , "Mercado" , "Tanner" , "Eaton" , "Clay" , "Barron" , "Beasley" , "Oneal" , "Preston" , "Small" , "Wu" , "Zamora" , "Macdonald" , "Vance" , "Snow" , "Mcclain" , "Stafford" , "Orozco" , "Barry" , "English" , "Shannon" , "Kline" , "Jacobson" , "Woodard" , "Huang" , "Kemp" , "Mosley" , "Prince" , "Merritt" , "Hurst" , "Villanueva" , "Roach" , "Nolan" , "Lam" , "Yoder" , "Mccullough" , "Lester" , "Santana" , "Valenzuela" , "Winters" , "Barrera" , "Leach" , "Orr" , "Berger" , "Mckee" , "Strong" , "Conway" , "Stein" , "Whitehead" , "Bullock" , "Escobar" , "Knox" , "Meadows" , "Solomon" , "Velez" , "Odonnell" , "Kerr" , "Stout" , "Blankenship" , "Browning" , "Kent" , "Lozano" , "Bartlett" , "Pruitt" , "Buck" , "Barr" , "Gaines" , "Durham" , "Gentry" , "Mcintyre" , "Sloan" , "Melendez" , "Rocha" , "Herman" , "Sexton" , "Moon" , "Hendricks" , "Rangel" , "Stark" , "Lowery" , "Hardin" , "Hull" , "Sellers" , "Ellison" , "Calhoun" , "Gillespie" , "Mora" , "Knapp" , "Mccall" , "Morse" , "Dorsey" , "Weeks" , "Nielsen" , "Livingston" , "Leblanc" , "Mclean" , "Bradshaw" , "Glass" , "Middleton" , "Buckley" , "Schaefer" , "Frost" , "Howe" , "House" , "Mcintosh" , "Ho" , "Pennington" , "Reilly" , "Hebert" , "Mcfarland" , "Hickman" , "Noble" , "Spears" , "Conrad" , "Arias" , "Galvan" , "Velazquez" , "Huynh" , "Frederick" , "Randolph" , "Cantu" , "Fitzpatrick" , "Mahoney" , "Peck" , "Villa" , "Michael" , "Donovan" , "Mcconnell" , "Walls" , "Boyle" , "Mayer" , "Zuniga" , "Giles" , "Pineda" , "Pace" , "Hurley" , "Mays" , "Mcmillan" , "Crosby" , "Ayers" , "Case" , "Bentley" , "Shepard" , "Everett" , "Pugh" , "David" , "Mcmahon" , "Dunlap" , "Bender" , "Hahn" , "Harding" , "Acevedo" , "Raymond" , "Blackburn" , "Duffy" , "Landry" , "Dougherty" , "Bautista" , "Shah" , "Potts" , "Arroyo" , "Valentine" , "Meza" , "Gould" , "Vaughan" , "Fry" , "Rush" , "Avery" , "Herring" , "Dodson" , "Clements" , "Sampson" , "Tapia" , "Bean" , "Lynn" , "Crane" , "Farley" , "Cisneros" , "Benton" , "Ashley" , "Mckay" , "Finley" , "Best" , "Blevins" , "Friedman" , "Moses" , "Sosa" , "Blanchard" , "Huber" , "Frye" , "Krueger" , "Bernard" , "Rosario" , "Rubio" , "Mullen" , "Benjamin" , "Haley" , "Chung" , "Moyer" , "Choi" , "Horne" , "Yu" , "Woodward" , "Ali" , "Nixon" , "Hayden" , "Rivers" , "Estes" , "Mccarty" , "Richmond" , "Stuart" , "Maynard" , "Brandt" , "Oconnell" , "Hanna" , "Sanford" , "Sheppard" , "Church" , "Burch" , "Levy" , "Rasmussen" , "Coffey" , "Ponce" , "Faulkner" , "Donaldson" , "Schmitt" , "Novak" , "Costa" , "Montes" , "Booker" , "Cordova" , "Waller" , "Arellano" , "Maddox" , "Mata" , "Bonilla" , "Stanton" , "Compton" , "Kaufman" , "Dudley" , "Mcpherson" , "Beltran" , "Dickson" , "Mccann" , "Villegas" , "Proctor" , "Hester" , "Cantrell" , "Daugherty" , "Cherry" , "Bray" , "Davila" , "Rowland" , "Levine" , "Madden" , "Spence" , "Good" , "Irwin" , "Werner" , "Krause" , "Petty" , "Whitney" , "Baird" , "Hooper" , "Pollard" , "Zavala" , "Jarvis" , "Holden" , "Haas" , "Hendrix" , "Mcgrath" , "Bird" , "Lucero" , "Terrell" , "Riggs" , "Joyce" , "Mercer" , "Rollins" , "Galloway" , "Duke" , "Odom" , "Andersen" , "Downs" , "Hatfield" , "Benitez" , "Archer" , "Huerta" , "Travis" , "Mcneil" , "Hinton" , "Zhang" , "Hays" , "Mayo" , "Fritz" , "Branch" , "Mooney" , "Ewing" , "Ritter" , "Esparza" , "Frey" , "Braun" , "Gay" , "Riddle" , "Haney" , "Kaiser" , "Holder" , "Chaney" , "Mcknight" , "Gamble" , "Vang" , "Cooley" , "Carney" , "Cowan" , "Forbes" , "Ferrell" , "Davies" , "Barajas" , "Shea" , "Osborn" , "Bright" , "Cuevas" , "Bolton" , "Murillo" , "Lutz" , "Duarte" , "Kidd" , "Key" , "Cooke"]

  SPORTS = ["Aquatic Sports", "Soccer", "Swimming", "Diving", "Water Polo", "Distance Swimming", "Track & Field", "Distance Running", "Cross Country", "Decathlon" , "Baseball", "Softball", "Basketball", "Bodybuilding", "Boxing", "Cricket", "Cycling", "Equestrian", "Fencing", "American Football", "Golf", "Gymnastics", "Handball" , "Hockey" , "Field Hockey" , "Ice Hockey", "Ice Skating", "Judo", "Ju-jitsu", "Karate", "Kendo", "Kickboxing", "Muay Thai", "Kung Fu", "Lacrosse", "Mixed Martial Arts", "Muay Thai", "Powerlifting", "Rowing", "Sailing", "Skateboarding", "Skiing", "Squash", "Sumo", "Surfing" , "Swimming", "Taekwondo", "Tennis", "Triathlon", "Volleyball" , "Beach Volleyball", "Weightlifting", "Wrestling"]

  PRESIDENTS = ["George Washington", "John Adams", "Thomas Jefferson", "James Madison", "James Monroe", "John Quincy Adams", "Andrew Jackson", "Martin Van Buren", "William Henry Harrison", "John Tyler", "James K. Polk", "Zachary Taylor", "Millard Fillmore", "Franklin Pierce" , "James Buchanan" , "Abraham Lincoln" , "Andrew Johnson" , "Ulysses S. Grant" , "Rutherford B. Hayes" , "James A. Garfield", "Chester Arthur", "Grover Cleveland" , "Benjamin Harrison" , "Grover Cleveland" , "William McKinley" , "Theodore Roosevelt" , "William Howard Taft" , "Woodrow Wilson", "Warren G. Harding", "Calvin Coolidge", "Herbert Hoover", "Franklin D. Roosevelt", "Henry A. Wallace", "Harry S. Truman", "Alben Barkley", "Dwight D. Eisenhower", "John F. Kennedy", "Lyndon B. Johnson", "Richard Nixon", "Gerald Ford", "Jimmy Carter", "Ronald Reagan", "George Bush", "Bill Clinton", "George W. Bush", "Barack Obama"]

  BLACK_PEOPLE = ["Martin Luther King", "Malcolm X", "George Washington Carver", "Sallie Mae Jamison", "Thurgood Marshall", "Frederick Douglass", "W.E.B Dubois", "Benjamin Banneker", "Charles Drew", "Garrett Morgan", "George Alcorn", "Patricia Bath", "Otis Boykin", "William Cardozo", "Frederick McKinley"]

  SCHOOL_SUFFIXES = ['High School', 'Academy', 'Vocational School', 'Technical', 'Charter', 'Prep']

  SCHOOL_SPORT_PREFIXES = ["Freshman", "JV", "Varsity"]

  SEX = ["Girls", "Boys"]

  LEVEL = ["Beginner", "Intermediate", "Elite", "Amateur Pro", "Professional"]

  SELECTION_CRITERIA = ["Open", "Varies", "Tryouts", "Invite-only"]

  AGE_RANGE = ["11-20", "5-9", "15-19", "16-21", "17-19", "Under 25", "Under 19","13-14", "13-16", "11-15", "20-22"]
  
  
  module ClassMethods
    # class methods
    
    def create_schools(number)
      Array(1..number).each do |i|
        suffix = SCHOOL_SUFFIXES.sample
        school_name = "#{[PRESIDENTS.sample, PRESIDENTS.sample.split(" ").last, BLACK_PEOPLE.sample].sample} #{suffix}"

        school = School.new(
          name: school_name,
          classification: suffix,
          abbreviation: school_name.split.map(&:first).join.upcase,
          linkedin: "http://www.linkedin.com/#{school_name.delete(' ')}#{i}",
          facebook: "http://www.facebook.com/#{school_name.delete(' ')}#{i}",
          instagram: "http://www.instagram.com/#{school_name.delete(' ')}#{i}",
          twitter: "http://www.twitter.com/#{school_name.delete(' ')}#{i}",
          youtube: "http://www.youtube.com/#{school_name.delete(' ')}#{i}",
          pinterest: "http://www.pinterest.com/#{school_name.delete(' ')}#{i}",
          foursquare: "http://www.foursquare.com/#{school_name.delete(' ')}#{i}",
          email: "#{school_name.delete(' ').downcase}@gmail.com",
          website: "http://www.#{i}-#{school_name.split.map(&:first).join.downcase}.com",
          phone_number: "#{(200..999).to_a.sample}-#{(200..999).to_a.sample}-#{(1000..9999).to_a.sample}",
          enrollment: rand(500..3000),
          faculty: rand(40..120),
          founded: rand(1900..2015),
          category: "",
          motto: "Strive for Excellence.",
          mascot: "Bears",
          colors: "Red, White, Blue",
          description: "This is a description of a school to see what it looks like!",
          number_of_teams: rand(4..20),
          )
          school.build_address(street_1: "1600 Pennsylvania Ave NW", city: "Washington", state: "District of Columbia", postcode: 20050)
          school.save!
      end
    end
    
    def create_clubs(number)
      Array(1..number).each do |i|
        club_name = "#{[PRESIDENTS.sample, PRESIDENTS.sample.split(" ").last, BLACK_PEOPLE.sample].sample}"
        level = LEVEL.sample
        sports = [SPORTS.sample, SPORTS.sample, SPORTS.sample]

        club = Club.new(
          name: club_name,
          abbreviation: club_name.split.map(&:first).join.upcase,
          linkedin: "http://www.linkedin.com/#{club_name.delete(' ')}#{i}",
          facebook: "http://www.facebook.com/#{club_name.delete(' ')}#{i}",
          instagram: "http://www.instagram.com/#{club_name.delete(' ')}#{i}",
          twitter: "http://www.twitter.com/#{club_name.delete(' ')}#{i}",
          youtube: "http://www.youtube.com/#{club_name.delete(' ')}#{i}",
          pinterest: "http://www.pinterest.com/#{club_name.delete(' ')}#{i}",
          foursquare: "http://www.foursquare.com/#{club_name.delete(' ')}#{i}",
          email: "#{club_name.delete(' ').downcase}@gmail.com",
          website: "http://www.#{i}-#{club_name.split.map(&:first).join.downcase}.com",
          phone_number: "#{(200..999).to_a.sample}-#{(200..999).to_a.sample}-#{(1000..9999).to_a.sample}",
          enrollment: rand(500..3000),
          faculty: rand(40..120),
          year_founded: rand(1900..2015),
          category: "",
          motto: "Strive for Excellence.",
          mascot: "Bears",
          colors: "Red, White, Blue",
          description: "This is a description of a school to see what it looks like!",
          number_of_teams: rand(4..20),
          level: level,
          selection_criteria: SELECTION_CRITERIA.sample,
          gender: ["Male", "Female", "Co-Ed"].sample,
          age_range: AGE_RANGE.sample,
          sports: sports,
          )
          club.build_address(street_1: "1585 Broadway", city: "New York", state: "New York", postcode: 10036)
          club.save!
      end
    end
    
    def create_teams(teamable_type)
      teamable_type.constantize.all.each do |object|
        1.times do
          sex = SEX.sample
          sport = SPORTS.sample
          team_name = teamable_type == "School" ? "#{SCHOOL_SPORT_PREFIXES.sample} #{sex} #{sport}" : "#{object.name} #{sex} #{sport}"
          team = Team.new(
            teamable_id: object.id,
            teamable_type: teamable_type,
            name: team_name,
            linkedin: "http://www.linkedin.com/#{team_name.delete(' ')}#{object.abbreviation}",
            facebook: "http://www.facebook.com/#{team_name.delete(' ')}#{object.abbreviation}",
            instagram: "http://www.instagram.com/#{team_name.delete(' ')}#{object.abbreviation}",
            twitter: "http://www.twitter.com/#{team_name.delete(' ')}#{object.abbreviation}",
            youtube: "http://www.youtube.com/#{team_name.delete(' ')}#{object.abbreviation}",
            pinterest: "http://www.pinterest.com/#{team_name.delete(' ')}#{object.abbreviation}",
            foursquare: "http://www.foursquare.com/#{team_name.delete(' ')}#{object.abbreviation}",
            email: "#{team_name.delete(' ').downcase}@gmail.com",
            phone_number: "#{(200..999).to_a.sample}-#{(200..999).to_a.sample}-#{(1000..9999).to_a.sample}",
            website: "http://www.#{object.abbreviation.downcase}-#{team_name.split.map(&:first).join.downcase}.com",
            sport: sport,
            description: "This is another description to see what it looks like for a team.",
            )
            team.build_address(street_1: "1600 Pennsylvania Ave NW", city: "Washington", state: "District of Columbia", postcode: 20050)
            team.save!
        end
      end
    end
    
    def create_leagues
      CITIES.first(1).each_with_index do |city, i|
          league_name = "#{city} #{["Public School League", "AAU Association", "Private School League", "Recreational", "Intramural"].sample}"

          league = League.new(
          name: league_name,
          linkedin: "http://www.linkedin.com/#{league_name.delete(' ')}#{i}",
          facebook: "http://www.facebook.com/#{league_name.delete(' ')}#{i}",
          instagram: "http://www.instagram.com/#{league_name.delete(' ')}#{i}",
          twitter: "http://www.twitter.com/#{league_name.delete(' ')}#{i}",
          youtube: "http://www.youtube.com/#{league_name.delete(' ')}#{i}",
          pinterest: "http://www.pinterest.com/#{league_name.delete(' ')}#{i}",
          email: "#{league_name.delete(' ').downcase}@gmail.com",
          phone_number: "#{(200..999).to_a.sample}-#{(200..999).to_a.sample}-#{(1000..9999).to_a.sample}",
          website: "http://www.#{league_name.downcase}-#{league_name.split.map(&:first).join.downcase}.com",
          classification: "",
          category: "",
          school_affiliated: league_name.split(" ").include?("School") ? true : false,
          description: "Lorem Isum - jk. We write custom fake text 'round here."
          )
          league.build_address(street_1: "1025 5th St NW", city: "Washington", state: "District of Columbia", postcode: 20001)
          league.save!
      end
    end
    
    def add_athletes_to_teams
      girls = Profile.where(sex: "Female").where("date_of_birth >= ?", 19.years.ago)
      boys =  Profile.where(sex: "Male").where("date_of_birth >= ?", 19.years.ago)
      girl_teams = Team.where("name LIKE ?", "%#{'girl'}%")
      boy_teams = Team.where("name LIKE ?", "%#{'boy'}%")

      girls.each do |object|
        4.times do
          Role.create(user_id: object.id, roleable_type: "Team", roleable_id: girl_teams.sample.id, status: "Active", role: "Athlete", jersey_number: (1..99).to_a.sample, level: ["Freshman", "Sophomore", "Junior", "Senior"].sample)
        end
      end

      boys.each do |object|
        4.times do
          Role.create(user_id: object.id, roleable_type: "Team", roleable_id: boy_teams.sample.id, status: "Active", role: "Athlete", jersey_number: (1..99).to_a.sample, level: ["Freshman", "Sophomore", "Junior", "Senior"].sample)
        end
      end
    end
    
    def add_adults_to_teams
      adults = Profile.where("date_of_birth <= ?", 19.years.ago)

      adults.each do |object|
        3.times do
          Role.create(user_id: object.id, roleable_type: "Team", roleable_id: adults.sample.id, status: "Active", role: ["Trainer", "Team Manager", "Coach", "Guardian"].sample, jersey_number: (1..99).to_a.sample, level: "")
        end
      end
    end
    
    def create_fans
      User.all.each do |user|
        Fan.create(user_id: user.id, fannable_id: User.all.sample.id, fannable_type: "User")
        Fan.create(user_id: user.id, fannable_id: Team.all.sample.id, fannable_type: "Team")
        Fan.create(user_id: user.id, fannable_id: School.all.sample.id, fannable_type: "School")
        Fan.create(user_id: user.id, fannable_id: Club.all.sample.id, fannable_type: "Club")
       # Fan.create(user_id: User.all.sample.id, fannable_id: Team.all.sample.id, fannable_type: "Facility")
       # Fan.create(user_id: User.all.sample.id, fannable_id: Team.all.sample.id, fannable_type: "")
      end
    end
    
    def add_addresses
      ["School", "Team", "Facility", "League"].each do |model| #no users, clubs
        model.constantize.all.each do |object|
          Address.create(addressable_id: object.id, addressable_type: object.class.to_s, street_1: object.address_1, street_2: object.address_2, city: object.city, state: object.state, country: "United States of America", postcode: object.zip)
        end
      end 
    end
    
    def add_roles
      Relationship.all.each do |rel|
        roles = [["participant?", "Athlete"], ["head?", "Coach"], ["manager?", "Team Manager"], ["trainer?", "Trainer"], ["admin?", "Admin"]].each do |role|
          rel.send(role.first) ? Role.create(user_id: rel.user_id, role: role.second, roleable_type: "Team", roleable_id: rel.team_id, status: "Active", jersey_number: rel.jersey_number, title: rel.head_title, level: rel.participant_classification, mobile_phone_number: rel.mobile_phone_number, nickname: rel.nickname  ) : nil
        end
      end
    end
   
    def create_user_with_certs
      user = User.create(first_name: "Coach", last_name: "Jones", password: "password", email: "coach@jones.com")
      profile = Profile.create(user_id: user.id)
      classification = Classification.create(classification: "Coach")
      role = Role.create(user_id: user.id, role: "Coach", status: "Active", roleable_type: "Team", roleable_id: Team.first.id)
      certification = Certification.create(name: "CPR", issuer: "Issuer Name")
      certificate = Certificate.create(user_id: user.id, certification_id: certification.id, expiration: (Date.today + 2.weeks), expires: true)
    end
    
    def convert_school_to_club(id)
      school = School.find(id)
      club = Club.new(
                  name: school.name,
                  classification: school.classification,
                  abbreviation: school.abbreviation,
                  phone_number: school.phone_number, 
                  email: school.email, 
                  website: school.website, 
                  stripe_customer_id: school.stripe_customer_id, 
                  last_payment: school.last_payment, 
                  stripe_subscription_id: school.stripe_subscription_id, 
                  premium: school.premium, 
                  price: school.price, 
                  facebook: school.facebook, 
                  twitter: school.twitter, 
                  linkedin: school.linkedin, 
                  pinterest: school.pinterest, 
                  instagram: school.instagram, 
                  foursquare: school.foursquare, 
                  youtube: school.youtube, 
                  description: school.description, 
                  colors: school.colors, 
                  mascot: school.mascot, 
                  motto: school.motto, 
                  number_of_teams: school.number_of_teams, 
                  category: school.category, 
                  founded: school.founded, 
                  enrollment: school.enrollment, 
                  faculty: school.faculty,
                  )
       club.build_address(
                          street_1: school.address.street_1, 
                          street_2: school.address.street_2, 
                          city: school.address.city, 
                          county: school.address.county, 
                          state: school.address.state, 
                          country: school.address.country, 
                          postcode: school.address.postcode, 
                          suite: school.address.suite, 
                          default: school.address.default, 
                          nickname: school.address.nickname, 
                          latitude: school.address.latitude, 
                          longitude: school.address.longitude,)  
          club.save!                     
                  
       school.roles.update_all(roleable_type: "Club", roleable_id: club.id)
       school.userless_roles.update_all(userless_id: club.id, userless_type: "Club")
       school.photos.update_all(photo_owner_id: club.id, photo_owner_type: "Club")
       school.teams.update_all(teamable_type: "Club", teamable_id: club.id)
       school.fans.update_all(fannable_id: club.id, fannable_type: "Club")
       school.events.update_all(eventable_id: club.id, eventable_type: "Club")
       school.facilities.update_all(facility_owner_type: "Club", facility_owner_id: club.id)
                  
    end
      
  end

  
end
