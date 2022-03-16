-- Include your create table DDL statements in this file.
-- Make sure to terminate each statement with a semicolon (;)

-- LEAVE this statement on. It is required to connect to your database.
CONNECT TO cs421;

-- Remember to put the create table ddls for the tables with foreign key references
--    ONLY AFTER the parent tables has already been created.

-- This is only an example of how you add create table ddls to this file.
--   You may remove it.

CREATE TABLE Tech(
	                     Name VARCHAR(20) NOT NULL,
			                     Pnum VARCHAR(20) NOT NULL UNIQUE,
					                     TechID VARCHAR(20) NOT NULL,
							                     PRIMARY KEY (TechID)
								);

								CREATE TABLE Mother(
									                       HeaCCard VARCHAR(30) NOT NULL,
											                       mName VARCHAR(20) NOT NULL,
													                       Birth DATE NOT NULL ,
															                       Address VARCHAR(50) NOT NULL,
																	                       Email VARCHAR(50) NOT NULL UNIQUE,
																			                       PhoneNum VARCHAR(20) NOT NULL UNIQUE,
																					                       mProfession VARCHAR(30) NOT NULL ,
																							                       mBloodType VARCHAR(5),
																									                       PRIMARY KEY(HeaCCard)
																										);

																										CREATE TABLE Father(
																											                       FatherID VARCHAR(30) NOT NULL,
																													                       fname VARCHAR(20) NOT NULL,
																															                       dob DATE NOT NULL,
																																	                       pNum VARCHAR(20) NOT NULL UNIQUE,
																																			                       fProfession VARCHAR(30) NOT NULL,
																																					                       fBloodType VARCHAR(5),
																																							                       PRIMARY KEY (FatherID)
																																								);

																																								CREATE TABLE institution(
																																									        IEmail VARCHAR(50) NOT NULL UNIQUE,
																																										        Iaddre VARCHAR(50) NOT NULL,
																																											        IName VARCHAR(50) NOT NULL,
																																												        IPnum VARCHAR(20) NOT NULL UNIQUE,
																																													        PRIMARY KEY(IEmail)
																																													);

																																													CREATE TABLE Midwifes(
																																														    PracID VARCHAR(30) NOT NULL,
																																														    Name VARCHAR(20) NOT NULL,
																																														    PNum VARCHAR(20) NOT NULL UNIQUE,
																																														    Email VARCHAR(50) NOT NULL UNIQUE,
																																														    IEmail VARCHAR(50) NOT NULL,
																																														    PRIMARY KEY(PracID),
																																														    FOREIGN KEY (IEmail) references institution
																																													);

																																													CREATE TABLE Couple(
																																														        CoupleID VARCHAR(30) NOT NULL,
																																															        HeaCCard VARCHAR(30) NOT NULL,
																																																        FatherID VARCHAR(30),
																																																	        PRIMARY KEY(CoupleID),
																																																		        FOREIGN KEY (FatherID) REFERENCES Father,
																																																			        FOREIGN KEY(HeaCCard) REFERENCES Mother
																																																			);

																																																			CREATE TABLE Appointment(
																																																				    AppointmentID VARCHAR(30) NOT NULL,
																																																				    ADate DATE NOT NULL,
																																																				    ATime TIME NOT NULL,
																																																				    CoupleID VARCHAR(30) NOT NULL,
																																																				    PracID VARCHAR(30) NOT NULL,
																																																				    PRIMARY KEY (AppointmentID),
																																																				    FOREIGN KEY (PracID) references Midwifes,
																																																				    FOREIGN KEY (CoupleID) references Couple
																																																			);

																																																			CREATE TABLE Pregnancy(
																																																				                          FinalEstDate DATE,
																																																							                          NewEstDate DATE,
																																																										                          BirthTime TIME,
																																																													                          InitialEstDate DATE,
																																																																                          PregID VARCHAR(20) NOT NULL,
																																																																			                          NumofPreg INTEGER NOT NULL,
																																																																						                          homeBirth boolean,
																																																																									                          IEmail VARCHAR(50),
																																																																												                          CoupleID VARCHAR(30) NOT NULL,
																																																																															                          PracID VARCHAR(30) NOT NULL,
																																																																																		                          BackUpID VARCHAR(30),
																																																																																					                          FOREIGN KEY (BackUpID) REFERENCES Midwifes(PracID),
																																																																																								                          PRIMARY KEY (PregID),
																																																																																											                          FOREIGN KEY(PracID) references Midwifes,
																																																																																														                          FOREIGN KEY (IEmail) references institution,
																																																																																																	                          FOREIGN KEY (CoupleID) REFERENCES Couple
																																																																																																			);

																																																																																																			CREATE TABLE Notes(
																																																																																																				    AppointmentID VARCHAR(30) NOT NULL,
																																																																																																				    content VARCHAR(1000),
																																																																																																				    Stime TIME NOT NULL,
																																																																																																				    SDate DATE NOT NULL,
																																																																																																				    NID VARCHAR(20) NOT NULL,
																																																																																																				    PracID VARCHAR(30) NOT NULL,
																																																																																																				    PregID VARCHAR(30) NOT NULL,
																																																																																																				    PRIMARY KEY(NID),
																																																																																																				    FOREIGN KEY(AppointmentID) references Appointment,
																																																																																																				    FOREIGN KEY (PracID) references Midwifes,
																																																																																																				    FOREIGN KEY (PregID) references Pregnancy
																																																																																																			);

																																																																																																			CREATE TABLE Website(
																																																																																																				                        URL VARCHAR(30) NOT NULL,
																																																																																																							                        PRIMARY KEY (URL)
																																																																																																									);

																																																																																																									CREATE TABLE WebPartner(
																																																																																																										    IEmail VARCHAR(30) NOT NULL,
																																																																																																										    URL VARCHAR(30) NOT NULL,
																																																																																																										    PRIMARY KEY (IEmail, URL),
																																																																																																										    FOREIGN KEY (IEmail) REFERENCES institution,
																																																																																																										    FOREIGN KEY (URL) references Website
																																																																																																									);

																																																																																																									CREATE TABLE CoupleSign(
																																																																																																										    CoupleID VARCHAR(30) NOT NULL,
																																																																																																										    URL VARCHAR(30) NOT NULL,
																																																																																																										    PRIMARY KEY (CoupleID, URL),
																																																																																																										    FOREIGN KEY (CoupleID) REFERENCES Couple,
																																																																																																										    FOREIGN KEY (URL) REFERENCES Website
																																																																																																									);


																																																																																																									CREATE TABLE Baby(
																																																																																																										  BabyID VARCHAR(30) NOT NULL,
																																																																																																										  PRIMARY KEY (BabyID),
																																																																																																										  PregID VARCHAR(30) NOT NULL,
																																																																																																										  FOREIGN KEY (PregID) references Pregnancy,
																																																																																																										  gender VARCHAR(7),
																																																																																																										  dob DATE,
																																																																																																										  btime TIME,
																																																																																																										  BloodType VARCHAR(5),
																																																																																																										  bname VARCHAR(20)
																																																																																																									);


																																																																																																									CREATE TABLE Test(
																																																																																																										  TestID VARCHAR(20) NOT NULL,
																																																																																																										  Type VARCHAR(20) NOT NULL,
																																																																																																										  PrecDate DATE NOT NULL,
																																																																																																										  sampleTestDate DATE,
																																																																																																										  LabDate DATE,
																																																																																																										  Result VARCHAR(200),
																																																																																																										  TechID VARCHAR(20) NOT NULL,
																																																																																																										  PracID VARCHAR(20) NOT NULL,
																																																																																																										  PregID VARCHAR(20) NOT NULL,
																																																																																																										  PRIMARY KEY (TestID),
																																																																																																										  FOREIGN KEY (TechID) references Tech,
																																																																																																										  FOREIGN KEY (PracID) references Midwifes,
																																																																																																										  FOREIGN KEY (PregID) references Pregnancy,
																																																																																																										  CHECK (PrecDate < Test.LabDate or LabDate is null)
																																																																																																									);

																																																																																																									CREATE TABLE InfoSession(
																																																																																																										    InfoID VARCHAR(30) NOT NULL ,
																																																																																																										    language VARCHAR(20) NOT NULL ,
																																																																																																										    Sdate DATE NOT NULL ,
																																																																																																										    Stime TIME NOT NULL ,
																																																																																																										    PracID VARCHAR(30) NOT NULL,
																																																																																																										    PRIMARY KEY (InfoID),
																																																																																																										    FOREIGN KEY (PracID) REFERENCES Midwifes
																																																																																																									);

																																																																																																									CREATE TABLE Assign(
																																																																																																										    CoupleID VARCHAR(30) NOT NULL,
																																																																																																										    InfoID VARCHAR(30) NOT NULL,
																																																																																																										    Attended boolean NOT NULL,
																																																																																																										    PRIMARY KEY(CoupleID, InfoID),
																																																																																																										    FOREIGN KEY (CoupleID) REFERENCES Couple,
																																																																																																										    FOREIGN KEY (InfoID) REFERENCES InfoSession
																																																																																																									);
