 
CREATE OR REPLACE
PACKAGE datafake
AS
 
  FUNCTION new_firstname
    RETURN VARCHAR2;
  FUNCTION new_lastname
    RETURN VARCHAR2;
  FUNCTION new_email(firstname IN VARCHAR2, lastname  IN VARCHAR2)
    RETURN VARCHAR2;
  FUNCTION new_address
    RETURN VARCHAR2;
  FUNCTION new_house
    RETURN VARCHAR2;
  FUNCTION new_street
    RETURN VARCHAR2;
  FUNCTION new_city
    RETURN VARCHAR2;
  FUNCTION new_region
    RETURN VARCHAR2;
  FUNCTION new_zip
    RETURN VARCHAR2;
  FUNCTION new_phone
    RETURN VARCHAR2;
  PROCEDURE init_seq(n IN pls_integer);
  FUNCTION new_seqval(seq IN pls_integer)
    RETURN NUMBER;
 FUNCTION new_seqval(seq IN pls_integer, pad IN NUMBER)
    RETURN VARCHAR2;
 
END datafake;
/
 
 
CREATE OR REPLACE
PACKAGE body datafake
AS
 
  -- create data types
  type va IS varray(255) OF VARCHAR2(255);
  type ht IS TABLE OF NUMBER INDEX BY pls_integer;
  first_name va;
  last_name va;
  email_domain va;
  street va;
  city va;
  region va;
  seqs ht;
 
  -- generate first name
  FUNCTION new_firstname
    RETURN VARCHAR2
  IS
    fname VARCHAR2(100);
    n     NUMBER;
  BEGIN
    fname := first_name(ceil(dbms_random.value(low => 1, high => first_name.count)));
    RETURN fname;
  END;

  -- generate last name
  FUNCTION new_lastname
    RETURN VARCHAR2
  IS
    lname VARCHAR2(100);
    n     NUMBER;
  BEGIN
    lname := last_name(ceil(dbms_random.value(low => 1, high => last_name.count)));
    RETURN lname;
  END;
  
  -- generate email address from name
  FUNCTION new_email(firstname IN VARCHAR2, lastname  IN VARCHAR2)
    RETURN VARCHAR2
 IS
    email_dom VARCHAR2(100);
    email  VARCHAR2(200);
  BEGIN
    email_dom := email_domain(ceil(dbms_random.value(low => 1, high => email_domain.count)));
    email := lower(firstname)||'.'||lower(lastname)||'@'||lower(email_dom);
    RETURN email;
 END;
  
  -- generate address
  FUNCTION new_address
    RETURN VARCHAR2
  IS
    ad_full   VARCHAR2(500);
    ad_house  VARCHAR(255);
    ad_street VARCHAR(255);
    ad_city   VARCHAR(255);
    ad_region VARCHAR(255);
    ad_zip    VARCHAR(255);
  BEGIN
    ad_house  := ceil(dbms_random.value(low => 1, high => 9999));
    ad_street := street(ceil(dbms_random.value(low => 1, high => street.count)));
    ad_city   := city(ceil(dbms_random.value(low => 1, high => city.count)));
    ad_region := region(ceil(dbms_random.value(low => 1, high => region.count)));
    ad_zip  := ceil(dbms_random.value(low => 10000, high => 99999))||'-'||ceil(dbms_random.value(low => 1000, high => 9999));
    ad_full := ad_house||', '||ad_street||', '||ad_city||', '||ad_region||', '||ad_zip||', US';
    RETURN ad_full;
  END;
  
  -- generate house number 
  FUNCTION new_house
    RETURN VARCHAR2
  IS
    ad_house  VARCHAR(255);
  BEGIN
    ad_house  := ceil(dbms_random.value(low => 1, high => 9999));
    RETURN ad_house;
  END;
 
  -- generate new street
  FUNCTION new_street
    RETURN VARCHAR2
  IS
    ad_street VARCHAR(255);
  BEGIN
    ad_street := street(ceil(dbms_random.value(low => 1, high => street.count)));
    RETURN ad_street;
  END;
 
  -- generate new city
  FUNCTION new_city
    RETURN VARCHAR2
  IS
    ad_city   VARCHAR(255);
  BEGIN
    ad_city   := city(ceil(dbms_random.value(low => 1, high => city.count)));
    RETURN ad_city;
  END;
 
  -- generate new state/region
  FUNCTION new_region
    RETURN VARCHAR2
  IS
    ad_region VARCHAR(255);
  BEGIN
    ad_region := region(ceil(dbms_random.value(low => 1, high => region.count)));
    RETURN ad_region;
  END;
 
  -- generate new zip code
  FUNCTION new_zip
    RETURN VARCHAR2
  IS
    ad_zip    VARCHAR(255);
  BEGIN
    ad_zip  := ceil(dbms_random.value(low => 10000, high => 99999))||'-'||ceil(dbms_random.value(low => 1000, high => 9999));
    RETURN ad_zip;
  END;
  
  -- generate phone number
  FUNCTION new_phone
    RETURN VARCHAR2
  IS
    ph VARCHAR2( 20);
  BEGIN
    ph := '('||ceil(dbms_random.value(low => 100, high => 999))||') '||ceil(dbms_random.value(low => 100, high => 999))||'-'||ceil(dbms_random.value(low => 1000, high => 9999));
    RETURN ph;
  END;
  
  -- initialize sequences
  PROCEDURE init_seq(n IN pls_integer)
  IS
  BEGIN
    FOR i IN 1..n
    LOOP
      seqs(i) := 1;
    END LOOP;
  END;
  
  -- generate new sequence value
  FUNCTION new_seqval(seq IN pls_integer)
    RETURN NUMBER
  IS
    orig NUMBER;
  BEGIN
    orig      := seqs(seq);
    seqs(seq) := orig+1;
    RETURN orig;
  END;
  -- generate new sequence value with padding
  FUNCTION new_seqval(seq IN pls_integer, pad IN NUMBER)
    RETURN VARCHAR2
  IS
    orig NUMBER;
  BEGIN
    orig      := seqs(seq);
    seqs(seq) := orig+1;
    RETURN lpad(orig, pad, '0');
  END;
BEGIN
  -- initialize data types
  first_name := va('Aditi', 'Aishwarya', 'Akansha', 'Akshita', 'Alisha', 'Anamika', 'Ananya', 'Angel', 'Anisha', 'Anita', 'Anjali', 'Ann', 'Anumeha', 'Anusha', 'Anushree', 'Apoorva', 'Archana', 'Archita', 'Arti', 'Arusha', 'Aswini', 'Bhagirathi', 'Chanchal', 'Deena', 'Deepthi', 'Diksha', 'Divya', 'Diya', 'Gayatri', 'Indhumathi', 'Ishika', 'Ishita', 'Jasmine', 'Kavitha', 'Kavya', 'Keerthi', 'Krithika', 'Lavanya', 'Leah', 'Liza', 'Lopa', 'Mahima', 'Manasa', 'Manisha', 'Meera', 'Megha', 'Menaja', 'Mitila', 'Nandita', 'Nikita', 'Nishi', 'Pavithra', 'Pooja', 'Poornima', 'Prachi', 'Pragya', 'Prerana', 'Priya', 'Priyanka', 'Radha', 'Radhika', 'Ramya', 'Ria', 'Richa', 'Rupali', 'Sakshi', 'Sana', 'Sanjana', 'Seema', 'Shivangi', 'Shreya', 'Shriya', 'Shruti', 'Simona', 'Sneha', 'Sonali', 'Srushti', 'Swati', 'Tanvi', 'Tanya', 'Tenzin', 'Tina', 'Vaishnavi', 'Varsha', 'Vidhya', 'Aaditya', 'Abhi', 'Abhijit', 'Abhinav', 'Abhishek', 'Aditya', 'Ajay', 'Ajith', 'Akash', 'Akshat', 'Akshay', 'Alok',
  'Amit', 'Ankit', 'Ankur', 'Apoorv', 'Arjun', 'Arun', 'Aryan', 'Ashish', 'Ashutosh', 'Ashwin', 'Babu', 'Darshan', 'Deepak', 'Dhruv', 'Dinesh', 'Hari', 'Harish', 'Harman', 'Himanshu', 'Inder', 'Jatin', 'Jay', 'Kapil', 'Karan', 'Karthik', 'Kaustubh', 'Kumar', 'Kunal', 'Mahesh', 'Manish', 'Manoj', 'Mayank', 'Mithun', 'Mohit', 'Neeraj', 'Nikhil', 'Nishant', 'Nitesh', 'Nithin', 'Nitin', 'Omkar', 'Palash', 'Pankaj', 'Parth', 'Prakash', 'Pranav', 'Prashant', 'Prateek', 'Prathamesh', 'Rahul', 'Raj', 'Rajeev', 'Rajesh', 'Raju', 'Rakesh', 'Ram', 'Ramanan', 'Ravi', 'Rishabh', 'Rohan', 'Rohit', 'Saini', 'Shail', 'Shashank', 'Shivam', 'Shubham', 'Shyam', 'Siddharth', 'Soham', 'Sourav', 'Sumeet', 'Sunny', 'Surya', 'Tauseen', 'Varun', 'Vatsal', 'Vedant', 'Vibhor', 'Vignesh', 'Vijay', 'Vishnu', 'Vivek', 'Yash', 'Yashwant');
  last_name := va('Agarwal', 'Arora', 'Aulakh', 'Banerjee', 'Bhargav', 'Bhatnagar', 'Bhatt', 'Bhattacharya', 'Bhosle', 'Bisht', 'Biswas', 'Bose', 'Brar', 'Chakraborty', 'Chand', 'Chandra', 'Chatterjee', 'Chattopadhyay', 'Chaudhary', 'Chauhan', 'Chavan', 'Chopra', 'Das', 'Dasgupta', 'Desai', 'Deshmukh', 'Deshpande', 'Dhaliwal', 'Dravid', 'D''souza', 'Dutt', 'Dutta', 'Dwivedi', 'Fernandes', 'Ganguly', 'Gavde', 'Gopal', 'Gounder', 'Gowda', 'Gupta', 'Inamdar', 'Iyer', 'Jain', 'Jaiteley', 'Jayaraman', 'Jha', 'Joshi', 'Kadam', 'Kamat', 'Kapoor', 'Kashyap', 'Kaur', 'Khan', 'Khanna', 'Kohli', 'Kothari', 'Kulkarni', 'Kumar', 'Lal', 'Malhotra', 'Malik', 'Meena', 'Mehra', 'Mehta', 'Mewati', 'Mishra', 'Mistry', 'Mitra', 'Mohanty', 'Mohapatra', 'Naidu', 'Nair', 'Narayan', 'Nayak', 'Nayar', 'Negi', 'Osman', 'Pal', 'Pandit', 'Pant', 'Parab', 'Parmar', 'Patel', 'Patil', 'Pawar', 'Pillai', 'Pradhan', 'Prasad', 'Purohit', 'Rai', 'Ram', 'Rana', 'Rangan', 'Rangarajan', 'Rao', 'Rathore', 'Rawat', 'Ray',
  'Reddy', 'Rodrigues', 'Roy', 'Saini', 'Sandhu', 'Sarin', 'Sarkar', 'Saxena', 'Sehgal', 'Sen', 'Sengupta', 'Shah', 'Sharma', 'Shetty', 'Shukla', 'Singh', 'Singhal', 'Sinha', 'Somani', 'Soni', 'Srinivasan', 'Srivastava', 'Subramanian', 'Swamy', 'Tambe', 'Thakur', 'Tomar', 'Trivedi', 'Upadhyay', 'Vaghela', 'Venkatesan', 'Verma', 'Yadav');
  email_domain := va('yahoo.com', 'hotmail.com', 'aol.com', 'gmail.com', 'msn.com', 'rediffmail.com');
  street       := va('Hidden Embers Diversion', 'Noble Moor', 'Round Common', 'Tawny Creek Woods', 'Gentle Swale', 'Fallen Terrace', 'Cotton Via', 'Hazy Panda Crossing', 'Pleasant Forest', 'Sunny Passage', 'Stony Pathway', 'Rustic By-pass', 'Blue Island Harbour', 'Old Crescent', 'Broad Key', 'Foggy Timber Manor', 'Sleepy Pointe', 'Heather Anchor Park', 'Velvet Willow Corners', 'Jagged Lagoon Rise', 'Middle Thicket', 'Lost Berry Trace', 'High Orchard', 'Silent Pines', 'Wishing Path', 'Dewy Lane', 'Easy Crest', 'Burning Hollow', 'Red Hickory Abbey', 'Green Cider Villas', 'Clear Cloud Street', 'Dusty Brook Knoll', 'Quiet Alley', 'Honey Highway', 'Golden Dell', 'Iron Jetty', 'Cinder Leaf Bank', 'Bright Gate Vale', 'Cozy Point', 'Umber Rabbit Lookout', 'Grand Towers', 'Emerald Beach', 'Rocky Run', 'Silver Wagon Highlands', 'Harvest Fawn Carrefour', 'Lazy Corner', 'Quaking Meadow', 'Shady Cove', 'Indian Hills Landing', 'Merry Deer Circuit');
  city         := va('White Eyes Town', 'Watercolor', 'Hawaiian Gardens', 'Owyhee', 'Bitter Root', 'Bull Run', 'Annaheim', 'Bonetraill', 'Jug Hole', 'Ops', 'Hercules', 'Quidnick', 'Drake', 'Killington', 'Rodney Village', 'Milwaukee', 'Stovepipe', 'Chappaquiddick', 'Mineral King', 'China Hat', 'Chimney Run', 'Snug Harbor', 'Manila', 'Del Monte', 'Slickpoo', 'Elevenpoint', 'Lespedeza', 'Fort San', 'Pensacola', 'Buchanan', 'Fish Rock', 'Nanjemoy', 'Dull', 'Dispatch', 'Crockett', 'Converse', 'Wood Trap', 'Free Deal', 'Regret', 'Cross Lanes', 'Aloha', 'Sleeping Buffalo', 'Spasticville', 'Maxinkuckee', 'Windthorst', 'Fort Misery', 'Stony Lonesome', 'Dodge', 'Idahome', 'Bullhead City');
  region       := va('Alaska', 'Arkansas', 'Connecticut', 'Delaware', 'District of Columbia', 'Florida', 'Georgia', 'Hawaii', 'Illinois', 'Kentucky', 'Louisiana', 'Maine', 'Maryland', 'Massachusetts', 'Missouri', 'Montana', 'Nebraska', 'Nevada', 'New Hampshire', 'New Mexico', 'New York', 'North Carolina''North Dakota', 'Ohio', 'Oklahoma', 'Rhode Island', 'South Carolina', 'Tennessee', 'Texas', 'Utah', 'Vermont', 'Wyoming');
END datafake;
/
 
show errors;
