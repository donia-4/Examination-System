--creating logins and adding user and and assigning roles
create login [John Doe] with password = 'u8k9H5tL';
create user [John Doe] for login [John Doe];
alter role TrainingManagerRole add member [John Doe];

-- Creating logins for each user
create login [Emma Watson] with password = 'a7R6b2U3';
create login [Michael Smith] with password = 'f9G7p2Vb';
create login [Sophia Johnson] with password = 'k7X2tB3v';
create login [James Williams] with password = 'h9Q3a2Tj';
create login [Olivia Brown] with password = 'r8K5mF2W';
create login [Liam Jones] with password = 'e4S9wR1D';
create login [Ava Miller] with password = 'p5G7dT4U';
create login [Lucas Davis] with password = 'o6W3jP2L';
create login [Isabella Garcia] with password = 'b9F5uQ4Z';
create login [Ethan Martinez] with password = 'm8B3lD5W';
create login [Mia Rodriguez] with password = 'j7K2tV9Y';
create login [Liam Anderson] with password = 'y6P8zB1V';
create login [Olivia Taylor] with password = 's9D7mF3G';
create login [Noah Wilson] with password = 'w4S2pJ5A';
create login [Emma Clark] with password = 'b6K3hT9Q';
create login [James Lewis] with password = 't1C7pR4N';
create login [Sophia Walker] with password = 'e3L5kJ2Z';
create login [Benjamin Hall] with password = 'a8R2wD6M';
create login [Isabella Allen] with password = 'm7G4vY3L';
create login [Mason Young] with password = 'f6U1sP7X';
create login [Charlotte King] with password = 'r9T2qF5B';
create login [Elijah Scott] with password = 'd3W7kN4P';
create login [Amelia Adams] with password = 'k4H6bG8Z';
create login [William Nelson] with password = 's9X1pJ7V';
create login [Lucas Carter] with password = 'h5T3mW2R';
create login [Harper Mitchell] with password = 'p8Q2sK6F';
create login [Alexander Perez] with password = 'a1V7lD5B';
create login [Mia Roberts] with password = 'w4J5gY8Z';
create login [Jackson Evans] with password = 'g9P2fT1A';
create login [Avery Green] with password = 'h5L9rB3W';
create login [Ella Baker] with password = 'f2P8wT7S';
create login [Sebastian Murphy] with password = 's9W4dY2K';
create login [Jack Harris] with password = 'g1D3eQ5F';
create login [Zoe Foster] with password = 'p6B9zN2T';
create login [Grace Ross] with password = 'h5V4cL3D';
create login [Oliver Morgan] with password = 'm2Q5nF7J';
create login [Chloe Cox] with password = 'f9J1dR3V';
create login [Jackson Bell] with password = 'd8R6yG4K';
create login [Maya Ward] with password = 'b2S9pL1X';
create login [Jacob Cooper] with password = 'r4T7gK8P';
create login [Emily Flores] with password = 'w1G9vT2P';
create login [Levi Gonzalez] with password = 'q3F6mD5R';
create login [Aiden Perez] with password = 't5Y8kV3H';
create login [Lily Morris] with password = 'a9T4jL6Q';
create login [Carter Price] with password = 'p7N3sF2Y';
create login [Zachary Hughes] with password = 'k6S9vT1X';
create login [Eleanor Powell] with password = 'd8Q5nV2Y';
create login [Amos Ward] with password = 't7L6xB1C';
create login [Nina Sanders] with password = 'f9P4uD3J';
create login [Samuel Clark] with password = 'b3X7sQ1N';
create login [Sophie Russell] with password = 'v2B9rJ8X';
create login [Daniel Peterson] with password = 'c4M7tW3V';
create login [Charlotte Carter] with password = 'n2K5dP8A';
create login [Henry James] with password = 'h4T3rQ9V';
create login [Natalie Rodriguez] with password = 'a7G9tL1D';
create login [Mason Garcia] with password = 'v3B2wP7T';
create login [Samantha Collins] with password = 'j6L4vT2M';
create login [Ethan Scott] with password = 'b5W2hR9Q';
create login [Megan Mitchell] with password = 'o1K9vG7T';
create login [Andrew Taylor] with password = 'f6Y3gP5M';
create login [Nora Young] with password = 'h4Q5sJ8L';
create login [Seth Wright] with password = 'b7N3pL6J';
create login [Anna Bell] with password = 't5M2rD7X';
create login [Benjamin Davis] with password = 'k1H6sP4Y';
create login [Eva Thompson] with password = 'f9W2kR3Z';
create login [Ryan Lopez] with password = 'j4P6mT7F';
create login [Ava Walker] with password = 'r8D3yP1B';
create login [Oscar Harris] with password = 'n7K9vL2Y';
create login [Nathan Turner] with password = 'o2Q7bV4C';
create login [Maya Clark] with password = 'w9L3tN1D';
create login [Grace Mitchell] with password = 'g5D9sY2K';
create login [Jackie Lopez] with password = 'e3T8rM4F';
--adding users and assigning rules
create user [Emma Watson] for login [Emma Watson];
alter role TrainingManagerRole add member [Emma Watson];

-- Create Instructors and assign role
create user [Michael Smith] for login [Michael Smith];
alter role InstructorRole add member [Michael Smith];

create user [Sophia Johnson] for login [Sophia Johnson];
alter role InstructorRole add member [Sophia Johnson];

create user [James Williams] for login [James Williams];
alter role InstructorRole add member [James Williams];

create user [Olivia Brown] for login [Olivia Brown];
alter role InstructorRole add member [Olivia Brown];

create user [Liam Jones] for login [Liam Jones];
alter role InstructorRole add member [Liam Jones];

create user [Ava Miller] for login [Ava Miller];
alter role InstructorRole add member [Ava Miller];

create user [Lucas Davis] for login [Lucas Davis];
alter role InstructorRole add member [Lucas Davis];

create user [Isabella Garcia] for login [Isabella Garcia];
alter role InstructorRole add member [Isabella Garcia];

create user [Ethan Martinez] for login [Ethan Martinez];
alter role InstructorRole add member [Ethan Martinez];

create user [Mia Rodriguez] for login [Mia Rodriguez];
alter role InstructorRole add member [Mia Rodriguez];

-- Create Students and assign role
create user [Liam Anderson] for login [Liam Anderson];
alter role StudentRole add member [Liam Anderson];

create user [Olivia Taylor] for login [Olivia Taylor];
alter role StudentRole add member [Olivia Taylor];

create user [Noah Wilson] for login [Noah Wilson];
alter role StudentRole add member [Noah Wilson];

create user [Emma Clark] for login [Emma Clark];
alter role StudentRole add member [Emma Clark];

create user [James Lewis] for login [James Lewis];
alter role StudentRole add member [James Lewis];

create user [Sophia Walker] for login [Sophia Walker];
alter role StudentRole add member [Sophia Walker];

create user [Benjamin Hall] for login [Benjamin Hall];
alter role StudentRole add member [Benjamin Hall];

create user [Isabella Allen] for login [Isabella Allen];
alter role StudentRole add member [Isabella Allen];

create user [Mason Young] for login [Mason Young];
alter role StudentRole add member [Mason Young];

create user [Charlotte King] for login [Charlotte King];
alter role StudentRole add member [Charlotte King];

create user [Elijah Scott] for login [Elijah Scott];
alter role StudentRole add member [Elijah Scott];

create user [Amelia Adams] for login [Amelia Adams];
alter role StudentRole add member [Amelia Adams];

create user [William Nelson] for login [William Nelson];
alter role StudentRole add member [William Nelson];

create user [Lucas Carter] for login [Lucas Carter];
alter role StudentRole add member [Lucas Carter];

create user [Harper Mitchell] for login [Harper Mitchell];
alter role StudentRole add member [Harper Mitchell];

create user [Alexander Perez] for login [Alexander Perez];
alter role StudentRole add member [Alexander Perez];

create user [Mia Roberts] for login [Mia Roberts];
alter role StudentRole add member [Mia Roberts];

create user [Jackson Evans] for login [Jackson Evans];
alter role StudentRole add member [Jackson Evans];

create user [Avery Green] for login [Avery Green];
alter role StudentRole add member [Avery Green];

create user [Ella Baker] for login [Ella Baker];
alter role StudentRole add member [Ella Baker];

create user [Sebastian Murphy] for login [Sebastian Murphy];
alter role StudentRole add member [Sebastian Murphy];

create user [Jack Harris] for login [Jack Harris];
alter role StudentRole add member [Jack Harris];

create user [Zoe Foster] for login [Zoe Foster];
alter role StudentRole add member [Zoe Foster];

create user [Grace Ross] for login [Grace Ross];
alter role StudentRole add member [Grace Ross];

create user [Oliver Morgan] for login [Oliver Morgan];
alter role StudentRole add member [Oliver Morgan];

create user [Chloe Cox] for login [Chloe Cox];
alter role StudentRole add member [Chloe Cox];

create user [Jackson Bell] for login [Jackson Bell];
alter role StudentRole add member [Jackson Bell];

create user [Maya Ward] for login [Maya Ward];
alter role StudentRole add member [Maya Ward];

create user [Jacob Cooper] for login [Jacob Cooper];
alter role StudentRole add member [Jacob Cooper];

create user [Emily Flores] for login [Emily Flores];
alter role StudentRole add member [Emily Flores];

create user [Levi Gonzalez] for login [Levi Gonzalez];
alter role StudentRole add member [Levi Gonzalez];

create user [Aiden Perez] for login [Aiden Perez];
alter role StudentRole add member [Aiden Perez];

create user [Lily Morris] for login [Lily Morris];
alter role StudentRole add member [Lily Morris];

create user [Carter Price] for login [Carter Price];
alter role StudentRole add member [Carter Price];

create user [Zachary Hughes] for login [Zachary Hughes];
alter role StudentRole add member [Zachary Hughes];

create user [Eleanor Powell] for login [Eleanor Powell];
alter role StudentRole add member [Eleanor Powell];

create user [Amos Ward] for login [Amos Ward];
alter role StudentRole add member [Amos Ward];

create user [Nina Sanders] for login [Nina Sanders];
alter role StudentRole add member [Nina Sanders];

create user [Samuel Clark] for login [Samuel Clark];
alter role StudentRole add member [Samuel Clark];

create user [Sophie Russell] for login [Sophie Russell];
alter role StudentRole add member [Sophie Russell];

create user [Daniel Peterson] for login [Daniel Peterson];
alter role StudentRole add member [Daniel Peterson];

create user [Charlotte Carter] for login [Charlotte Carter];
alter role StudentRole add member [Charlotte Carter];

create user [Henry James] for login [Henry James];
alter role StudentRole add member [Henry James];

create user [Natalie Rodriguez] for login [Natalie Rodriguez];
alter role StudentRole add member [Natalie Rodriguez];

create user [Mason Garcia] for login [Mason Garcia];
alter role StudentRole add member [Mason Garcia];

create user [Samantha Collins] for login [Samantha Collins];
alter role StudentRole add member [Samantha Collins];

create user [Ethan Scott] for login [Ethan Scott];
alter role StudentRole add member [Ethan Scott];

create user [Megan Mitchell] for login [Megan Mitchell];
alter role StudentRole add member [Megan Mitchell];

create user [Andrew Taylor] for login [Andrew Taylor];
alter role StudentRole add member [Andrew Taylor];

create user [Nora Young] for login [Nora Young];
alter role StudentRole add member [Nora Young];

create user [Seth Wright] for login [Seth Wright];
alter role StudentRole add member [Seth Wright];

create user [Anna Bell] for login [Anna Bell];
alter role StudentRole add member [Anna Bell];

create user [Benjamin Davis] for login [Benjamin Davis];
alter role StudentRole add member [Benjamin Davis];

create user [Eva Thompson] for login [Eva Thompson];
alter role StudentRole add member [Eva Thompson];

create user [Ryan Lopez] for login [Ryan Lopez];
alter role StudentRole add member [Ryan Lopez];

create user [Ava Walker] for login [Ava Walker];
alter role StudentRole add member [Ava Walker];

create user [Oscar Harris] for login [Oscar Harris];
alter role StudentRole add member [Oscar Harris];

create user [Nathan Turner] for login [Nathan Turner];
alter role StudentRole add member [Nathan Turner];

create user [Maya Clark] for login [Maya Clark];
alter role StudentRole add member [Maya Clark];

create user [Grace Mitchell] for login [Grace Mitchell];
alter role StudentRole add member [Grace Mitchell];

create user [Jackie Lopez] for login [Jackie Lopez];
alter role StudentRole add member [Jackie Lopez];
