module Location
  extend ActiveSupport::Concern

  def residence
    "#{city}, #{state_abbreviation}"
  end 
    
  def location_description
    case city 
    when "New York City"
      "NYC Metro Area"
    when "Los Angeles" 
      "Los Angeles, California Area"
    when "Chicago"
      "Chicago, IL"	
    when "Houston" 
      "Houston, TX"	
    when "Philadelphia" 
       "#{city}, PA"
    when "Phoenix"
      residence
    when "San Antonio"
      residence	
    when "San Diego" 
      residence
    when "Dallas"
      "Dallas/Fort Worth, Texas Area"	
    when "San Jose"
      residence
    when "Austin"
      residence	
    when "Jacksonville"
      residence	
    when "Indianapolis"
      residence	
    when "San Francisco"
      residence
    when "Columbus"
      residence	
    when "Fort Worth"
      "Dallas/Fort Worth, Texas Area"	
    when "Charlotte"
      residence	
    when "Detroit"
      "Motor City Michigan"	
    when "El Paso"
      residence	
    when "Memphis"
      residence	
    when "Boston" 
      residence	
    when "Seattle"
      residence	
    when "Denver"
      residence	
    when "Washington"
      "DC: The Nation's Capital"	
    when "Nashville-Davidson"
      residence	
    when "Baltimore"
      "Baltimore, Maryland Area"	
    when "Louisville-Jefferson"
      residence	
    when "Portland"
      residence	
    when "Oklahoma City"
      residence	
    when "Milwaukee"
      residence	
    when "Las Vegas"
      residence	
    when "Albuquerque"
      residence
    when "Tucson"
      residence	
    when "Fresno"
      residence
    when "Sacramento"
      residence
    when "Long Beach"
      residence
    when "Kansas-MO"
      residence	
    when "Mesa"
      residence	
    when "Virginia Beach"
      residence	
    when "Atlanta"
      residence	
    when "Colorado Springs"
      residence	
    when "Raleigh"
      residence	
    when "Omaha"
      residence	
    when "Miami"
      residence	
    when "Oakland"
      residence
    when "Tulsa"
      residence	
    when "Minneapolis"
      residence	
    when "Cleveland"
      residence	
    when "Wichita"
      residence	
    when "Arlington"
      residence	
    when "New Orleans"
      residence	
    when "Bakersfield"
      residence	
    when "Tampa"
      residence	
    when "Honolulu"
      residence	
    when "Anaheim"
      residence	
    when "Aurora-CO" 
      "Aurora, Colorado"	
    when "Santa Ana" 
      residence	
    when "St. Louis" 
      residence	
    when "Riverside" 
      residence	
    when "Corpus Christi" 
      residence	
    when "Pittsburgh" 
      residence	
    when "Lexington-Fayette" 
      residence	
    when "Anchorage"
      residence	
    when "Stockton" 
      residence	
    when "Cincinnati" 
      residence	
    when "St. Paul" 
      residence	
    when "Toledo" 
      residence	
    when "Newark" 
      residence	
    when "Greensboro" 
      residence	
    when "Plano" 
      residence	
    when "Henderson"
      residence	
    when "Lincoln"
      residence	
    when "Buffalo"
      residence	
    when "Fort Wayne"
      residence	
    when "Jersey City"
      residence	
    when "Chula Vista"
      residence	
    when "Orlando"
      residence	
    when "St. Petersburg"
      residence	
    when "Norfolk"
      residence	
    when "Chandler"
      residence	
    when "Laredo"
      residence	
    when "Madison"
      residence
    when "Durham"
      residence	
    when "Lubbock"
      residence	
    when "Winston-Salem"
      residence	
    when "Garland"
      residence	
    when "Glendale"
      residence	
    when "Hialeah"
      residence	
    when "Reno"
      residence
    when "Baton Rouge"
      residence	
    when "Irvine"
      residence	
    when "Chesapeake"
      residence	
    when "Irving"
      residence	
    when "Scottsdale"
      residence	
    when "North Las Vegas"
      residence	
    when "Fremont"
      residence	
    when "Gilbert"
      residence	
    when "San Bernardino"
      residence
    when "Boise"
      residence	
    when "Birmingham"
      residence	
    when "Rochester"
      residence	
    when "Richmond"
      residence	
    when "Spokane" 
      residence	
    when "Des Moines" 
      residence	
    when "Montgomery" 
      residence	
    when "Modesto" 
      residence	
    when "Fayetteville"
       residence	
    when "Tacoma"
      residence	
    when "Shreveport" 
      residence
    when "Fontana" 
      residence	
    when "Oxnard" 
      residence
    when "Aurora-IL" 
      "Aurora, IL"	
    when "Moreno Valley" 
      residence	
    when "Akron"
      residence	
    when "Yonkers"
      residence	
    when "Columbus-GA" 
      "Columbus, GA"	
    when "Augusta-Richmond"
      residence	
    when "Little Rock"
      residence	
    when "Amarillo"
      residence
    when "Mobile"
      residence
    when "Huntington Beach"
      residence	
    when "Glendale"
      residence	
    when "Grand Rapids"
      residence	
    when "Salt Lake City"
      residence	
    when "Tallahassee"
      residence	
    when "Huntsville" 
      residence
    when "Worcester"
      residence	
    when "Knoxville"
      residence	
    when "Grand Prairie"
      residence	
    when "Newport News"
      residence	
    when "Brownsville"
      residence	
    when "Santa Clarita"
      residence	
    when "Overland Park"
      residence	
    when "Providence"
      residence	
    when "Jackson"
      residence	
    when "Garden Grove"
      residence	
    when "Oceanside"
      residence	
    when "Chattanooga"
      residence	
    when "Fort Lauderdale"
      residence	
    when "Rancho Cucamonga"
      residence	
    when "Santa Rosa"
      residence	
    when "Port St. Lucie"
      residence	
    when "Ontario"
      residence	
    when "Tempe"
      residence	
    when "Vancouver"
      residence	
    when "Springfield-MO"
      "Springfield, MO"	
    when "Cape Coral"
      residence	
    when "Pembroke Pines"
      residence	
    when "Sioux Falls"
      residence	
    when "Peoria"
      residence	
    when "Lancaster"
      residence	
    when "Elk Grove"
      residence	
    when "Corona"
      residence
    when "Eugene"
      residence	
    when "Salem"
      residence	
    when "Palmdale"
      residence	
    when "Salinas"
      residence	
    when "Springfield-MA"
      "Springfield, MA"	
    when "Pasadena-TX"
      "Pasadena, TX"	
    when "Rockford"
      residence	
    when "Pomona"
      residence
    when "Hayward"
      residence	
    when "Fort Collins"
      residence
    when "Joliet"
       residence	
    when "Escondido"
      residence	
    when "Kansas-KS"
      residence	
    when "Torrance"
      residence	
    when "Bridgeport"
      residence	
    when "Alexandria"
      residence	
    when "Sunnyvale"
      residence
    when "Cary"
      residence	
    when "Lakewood"
      residence
    when "Hollywood"
      residence	
    when "Paterson"
      residence	
    when "Syracuse"
      residence	
    when "Naperville"
      residence	
    when "McKinney"
      residence	
    when "Mesquite"
      residence	
    when "Clarksville"
      residence	
    when "Savannah"
      residence	
    when "Dayton"
      residence	
    when "Orange"
      residence	
    when "Fullerton"
      residence	
    when "Pasadena"
      residence	
    when "Hampton"
      residence	
    when "McAllen"
      residence	
    when "Killeen"
      residence	
    when "Warren"
      residence	
    when "West Valley"
      residence	
    when "Columbia"
      residence	
    when "New Haven"
      residence	
    when "Sterling Heights"
      residence	
    when "Olathe"
      residence	
    when "Miramar"
      residence	
    when "Thousand Oaks"
      residence	
    when "Frisco"
      residence	
    when "Cedar Rapids"
      residence	
    when "Topeka"
      residence	
    when "Visalia"
      residence	
    when "Waco"
      residence
    end
  end
  
  def state_abbreviation
    case city
    when "New York City"
      "NY"
    when "Los Angeles"
      "CA"
    when "Chicago"
      "IL"
    when "Houston"
      "TX"
    when "Philadelphia"
       "PA"
    when "Phoenix"
      "AZ"
    when "San Antonio"
      "TX"
    when "San Diego"
      "CA"
    when "Dallas"
      "TX"
    when "San Jose"
      "CA"
    when "Austin"
      "TX"
    when "Jacksonville"
      "FL"
    when "Indianapolis"
      "IN"
    when "San Francisco"
      "CA"
    when "Columbus"
      "OH"
    when "Fort Worth"
      "TX"
    when "Charlotte"
      "NC"
    when "Detroit"
      "MI"
    when "El Paso"
      "TX"
    when "Memphis"
      "TN"
    when "Boston"
      "MA"
    when "Seattle"
      "WA"
    when "Denver"
      "CO"
    when "Washington"
      "DC"
    when "Nashville-Davidson"
      "TN"
    when "Baltimore"
      "MD"
    when "Louisville-Jefferson"
      "KY"
    when "Portland"
      "OR"
    when "Oklahoma City"
      "OK"
    when "Milwaukee"
      "WI"
    when "Las Vegas"
      "NV"
    when "Albuquerque"
      "NM"
    when "Tucson"
      "AZ"
    when "Fresno"
      "CA"
    when "Sacramento"
      "CA"
    when "Long Beach"
      "CA"
    when "Kansas-MO"
      "MO"
    when "Mesa"
      "AZ"
    when "Virginia Beach"
      "VA"
    when "Atlanta"
      "GA"
    when "Colorado Springs"
      "CO"
    when "Raleigh"
      "NC"
    when "Omaha"
      "NE"
    when "Miami"
      "FL"
    when "Oakland"
      "CA"
    when "Tulsa"
      "OK"
    when "Minneapolis"
      "MN"
    when "Cleveland"
      "OH"
    when "Wichita"
      "KS"
    when "Arlington"
      "TX"
    when "New Orleans"
      "LA"
    when "Bakersfield"
      "CA"
    when "Tampa"
      "FL"
    when "Honolulu"
      "HI"
    when "Anaheim"
      "CA"
    when "Aurora-CO"
      "CO"
    when "Santa Ana"
      "CA"
    when "St. Louis"
      "MO"
    when "Riverside"
      "CA"
    when "Corpus Christi"
      "TX"
    when "Pittsburgh"
      "PA"
    when "Lexington-Fayette"
      "KY"
    when "Anchorage"
      "AL"
    when "Stockton"
      "CA"
    when "Cincinnati"
      "OH"
    when "St. Paul"
      "MN"
    when "Toledo"
      "OH"
    when "Newark"
      "NJ"
    when "Greensboro"
      "NC"
    when "Plano"
      "TX"
    when "Henderson"
      "NV"
    when "Lincoln"
      "NE"
    when "Buffalo"
      "NY"
    when "Fort Wayne"
      "IN"
    when "Jersey City"
      "NJ"
    when "Chula Vista"
      "CA"
    when "Orlando"
      "FL"
    when "St. Petersburg"
      "FL"
    when "Norfolk"
      "VA"
    when "Chandler"
      "AZ"
    when "Laredo"
      "TX"
    when "Madison"
      "WI"
    when "Durham"
      "NC"
    when "Lubbock"
      "TX"
    when "Winston-Salem"
      "NC"
    when "Garland"
      "TX"
    when "Glendale"
      "AZ"
    when "Hialeah"
      "FL"
    when "Reno"
      "NV"
    when "Baton Rouge"
      "LA"
    when "Irvine"
      "CA"
    when "Chesapeake"
      "VA"
    when "Irving"
      "TX"
    when "Scottsdale"
      "AZ"
    when "North Las Vegas"
      "NV"
    when "Fremont"
      "CA"
    when "Gilbert"
      "AZ"
    when "San Bernardino"
      "CA"
    when "Boise"
      "ID"
    when "Birmingham"
      "AL"
    when "Rochester"
      "NY"
    when "Richmond"
      "VA"
    when "Spokane"
        "WA"
    when "Des Moines"
      "IA"
    when "Montgomery"
      "AL"
    when "Modesto"
      "CA"
    when "Fayetteville"
       "NC"
    when "Tacoma"
      "WA"
    when "Shreveport"
      "LA"
    when "Fontana"
      "CA"
    when "Oxnard"
      "CA"
    when "Aurora-IL"
      "IL"
    when "Moreno Valley"
      "CA"
    when "Akron"
      "OH"
    when "Yonkers"
      "NY"
    when "Columbus-GA"
      "GA"
    when "Augusta-Richmond"
      "GA"
    when "Little Rock"
      "AR"
    when "Amarillo"
      "TX"
    when "Mobile"
      "AL"
    when "Huntington Beach"
      "CA"
    when "Glendale"
      "CA"
    when "Grand Rapids"
      "MI"
    when "Salt Lake City"
      "UT"
    when "Tallahassee"
      "FL"
    when "Huntsville"
      "AL"
    when "Worcester"
      "MA"
    when "Knoxville"
      "TN"
    when "Grand Prairie"
      "TX"
    when "Newport News"
      "VA"
    when "Brownsville"
      "TX"
    when "Santa Clarita"
      "CA"
    when "Overland Park"
      "KS"
    when "Providence"
      "RI"
    when "Jackson"
      "MS"
    when "Garden Grove"
      "CA"
    when "Oceanside"
      "CA"
    when "Chattanooga"
      "TN"
    when "Fort Lauderdale"
      "FL"
    when "Rancho Cucamonga"
      "CA"
    when "Santa Rosa"
      "CA"
    when "Port St. Lucie"
      "FL"
    when "Ontario"
      "CA"
    when "Tempe"
      "AZ"
    when "Vancouver"
      "WA"
    when "Springfield-MO"
      "MO"
    when "Cape Coral"
      "FL"
    when "Pembroke Pines"
      "FL"
    when "Sioux Falls"
      "SD"
    when "Peoria"
      "AZ"
    when "Lancaster"
      "CA"
    when "Elk Grove"
      "CA"
    when "Corona"
      "CA"
    when "Eugene"
      "OR"
    when "Salem"
      "OR"
    when "Palmdale"
      "CA"
    when "Salinas"
      "CA"
    when "Springfield-MA"
      "MA"
    when "Pasadena-TX"
      "TX"
    when "Rockford"
      "IL"
    when "Pomona"
      "CA"
    when "Hayward"
      "CA"
    when "Fort Collins"
      "CO"
    when "Joliet"
       "IL"
    when "Escondido"
      "CA"
    when "Kansas-KS"
      "KS"
    when "Torrance"
      "CA"
    when "Bridgeport"
      "CT"
    when "Alexandria"
      "VA"
    when "Sunnyvale"
      "CA"
    when "Cary"
      "NC"
    when "Lakewood"
      "CO"
    when "Hollywood"
      "FL"
    when "Paterson"
      "NJ"
    when "Syracuse"
      "NY"
    when "Naperville"
      "IL"
    when "McKinney"
      "TX"
    when "Mesquite"
      "TX"
    when "Clarksville"
      "TN"
    when "Savannah"
      "GA"
    when "Dayton"
      "OH"
    when "Orange"
      "CA"
    when "Fullerton"
      "CA"
    when "Pasadena"
      "CA"
    when "Hampton"
      "VA"
    when "McAllen"
      "TX"
    when "Killeen"
      "TX"
    when "Warren"
      "MI"
    when "West Valley"
      "UT"
    when "Columbia"
      "SC"
    when "New Haven"
      "CT"
    when "Sterling Heights"
      "MI"
    when "Olathe"
      "KS"
    when "Miramar"
      "FL"
    when "Thousand Oaks"
      "CA"
    when "Frisco"
      "TX"
    when "Cedar Rapids"
      "IA"
    when "Topeka"
      "KS"
    when "Visalia"
      "CA"
    when "Waco"
      "TX"
    end
  end
  
  module ClassMethods
    
    def cities_list
      ["New York City", "Los Angeles", "Chicago", "Houston", "Philadelphia", "Phoenix", "San Antonio", "San Diego", "Dallas", "San Jose", "Austin", "Jacksonville", "Indianapolis", "San Francisco", "Columbus", "Fort Worth", "Charlotte", "Detroit", "El Paso", "Memphis", "Boston", "Seattle", "Denver", "Washington", "Nashville-Davidson", "Baltimore", "Louisville-Jefferson", "Portland", "Oklahoma City", "Milwaukee", "Las Vegas", "Albuquerque", "Tucson", "Fresno", "Sacramento", "Long Beach", "Kansas-MO", "Mesa", "Virginia Beach", "Atlanta", "Colorado Springs", "Raleigh", "Omaha", "Miami", "Oakland", "Tulsa", "Minneapolis", "Cleveland", "Wichita", "Arlington", "New Orleans", "Bakersfield", "Tampa", "Honolulu", "Anaheim", "Aurora-CO", "Santa Ana", "St. Louis", "Riverside", "Corpus Christi", "Pittsburgh", "Lexington-Fayette", "Anchorage", "Stockton", "Cincinnati", "St. Paul", "Toledo", "Newark", "Greensboro", "Plano", "Henderson", "Lincoln", "Buffalo", "Fort Wayne", "Jersey City", "Chula Vista", "Orlando", "St. Petersburg", "Norfolk", "Chandler", "Laredo", "Madison", "Durham", "Lubbock", "Winston-Salem", "Garland", "Glendale", "Hialeah", "Reno", "Baton Rouge", "Irvine", "Chesapeake", "Irving", "Scottsdale", "North Las Vegas", "Fremont", "Gilbert", "San Bernardino", "Boise", "Birmingham", "Rochester", "Richmond", "Spokane", "Des Moines", "Montgomery", "Modesto", "Fayetteville", "Tacoma", "Shreveport", "Fontana", "Oxnard", "Aurora-IL", "Moreno Valley", "Akron", "Yonkers", "Columbus-GA", "Augusta-Richmond", "Little Rock", "Amarillo", "Mobile", "Huntington Beach", "Glendale", "Grand Rapids", "Salt Lake City", "Tallahassee", "Huntsville", "Worcester", "Knoxville", "Grand Prairie", "Newport News", "Brownsville", "Santa Clarita", "Overland Park", "Providence", "Jackson", "Garden Grove", "Oceanside", "Chattanooga", "Fort Lauderdale", "Rancho Cucamonga", "Santa Rosa", "Port St. Lucie", "Ontario", "Tempe", "Vancouver", "Springfield-MO", "Cape Coral", "Pembroke Pines", "Sioux Falls", "Peoria", "Lancaster", "Elk Grove", "Corona", "Eugene", "Salem", "Palmdale", "Salinas", "Springfield-MA", "Pasadena-TX", "Rockford", "Pomona", "Hayward", "Fort Collins", "Joliet", "Escondido", "Kansas-KS", "Torrance", "Bridgeport", "Alexandria", "Sunnyvale", "Cary", "Lakewood", "Hollywood", "Paterson", "Syracuse", "Naperville", "McKinney", "Mesquite", "Clarksville", "Savannah", "Dayton", "Orange", "Fullerton", "Pasadena", "Hampton", "McAllen", "Killeen", "Warren", "West Valley", "Columbia", "New Haven", "Sterling Heights", "Olathe", "Miramar", "Thousand Oaks", "Frisco", "Cedar Rapids", "Topeka", "Visalia", "Waco"]
    end
    
    def countries_list
      ["Afghanistan", "Algeria", "Argentina","Australia","Bangladesh","Brazil","Cameroon", "Canada","Colombia","Denmark","Egypt","Ethiopia","France","Germany","Ghana","Greece","India","Indonesia","Iraq","Ireland","Israel","Italy","Japan","Kenya","Madagascar","Malaysia","Mexico","Morocco","Mozambique","Nepal","Netherlands","New Zealand","Nigeria","Pakistan","Peru","Philippines","Poland","Romania","Russia","Saudi Arabia","Singapore","South Africa","South Korea","Spain","Sri Lanka","Sweden","Switzerland","Taiwan","Tanzania","Thailand","Turkey","Uganda","Ukraine","United Kingdom","United States","Uzbekistan","Venezuela","Vietnam","Yemen"]
    end
    
    
    
  end
  
end	





