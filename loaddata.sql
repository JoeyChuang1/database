-- Include your INSERT SQL statements in this file.
-- Make sure to terminate each statement with a semicolon (;)

-- LEAVE this statement on. It is required to connect to your database.
CONNECT TO cs421;

-- Remember to put the INSERT statements for the tables with foreign key references
--    ONLY AFTER the parent tables!

-- This is only an example of how you add INSERT statements to this file.
--   You may remove it.
-- A more complex syntax that saves you typing effort.
INSERT INTO Tech (Name, Pnum, TechID) VALUES
        ('Julia', '135-031-293', 'Tech001'),
	        ('Drusen', '231-789-123', 'Tech002'),
		        ('Juol', '235-031-293', 'Tech003'),
			        ('Jolin', '335-031-293', 'Tech004'),
				        ('JTange', '435-031-293', 'Tech005');

					INSERT INTO Mother (HeaCCard, mName, Birth, Address, Email, PhoneNum, mProfession, mBloodType) VALUES
					         ('HeaCard001', 'Sarah', '1996-01-02', '8990 Chi.st', 'Sarah@Gmail.com', '604-222-123', 'HouseWife', NULL),
						         ('HeaCard002', 'Jenny', '1995-01-03', '3440 Sherbrook.st', 'Jenny@Gmail.com', '612-230-768', 'Sofeware Engineer', 'A+'),
							         ('HeaCard003', 'Annie', '1994-01-02', '3451 Aylmer.st', 'Annie@Gmail.com', '621-002-123', 'Water Engineer', 'B-'),
								         ('HeaCard004', 'Anja', '1993-02-04', '1234 Josseph.st', 'Josseph@Gmail.com', '123-321-521', 'Earth Bender', 'A-'),
									         ('HeaCard005', 'Victoria Gutierrez', '1992-01-05', '1267 Josseph.st', 'Josseph12@Gmail.com', '123-521-521', 'Fire Bender', 'A-');

										INSERT INTO FATHER (FatherID, fname, dob, pNum, fProfession, fBloodType) VALUES
										                ('Father001', 'David', '1995-01-01', '123-332-132', 'SoftwareEngineer', NULL),
												                ('Father002', 'Jad', '1920-01-01', '123-332-133', 'No Job', 'O+'),
														                ('Father003', 'Jusen', '1920-01-01', '1231-332-133', 'No Job', 'O+'),
																                ('Father004', 'Jady', '1920-01-01', '1232-332-133', 'No Job', 'O+'),
																		                ('Father005', 'Jfke', '1920-01-01', '1233-332-133', 'No Job', 'O+');

																				INSERT INTO INSTITUTION (IEmail, Iaddre, IName, IPnum) VALUES
																				             ('Cisco@Gmail.com', '3124 Sherbrook.st', 'Cisco Birthing Cent', '213-123-123'),
																					             ('McGill@Gmail.com', '2145 Sherbrook.st', 'McGill Birthing Cent', '123-432-123'),
																						             ('Mario4@gmail.com', '4444 Mario.st', 'Mario4 Alpha Birthing Center', '947-293-921'),
																							             ('Mario3@gmail.com', '3333 Mario.st', 'Mario3 Coop Birthing Center', '832-912-983'),
																								             ('Mario2@gmail.com', '2222 Mario.st', 'Mario2 Duda Birthing Center', '947-293-922'),
																									             ('Mario@gmail.com', '1111 Mario.st', 'Mario1 Beta Birthing Center', '549-947-678'),
																										             ('SaintLouis@gmail.com', 'Lac-Saint-Louis st', 'Lac-Saint-Louise', '129-912-890');


																											INSERT INTO MIDWIFES (PracID, Name, PNum, Email, IEmail) VALUES
																											        ('000001', 'Luke', '513-213-012', 'Luke.Luo@gmail.com', 'Cisco@Gmail.com'),
																												        ('000002', 'Marion Girard', '413-123-012', 'Brulio@gmail.com', 'McGill@Gmail.com'),
																													        ('000003', 'Joseph Silva', '778-821-293', 'Joseph@gmail.com', 'Mario2@gmail.com'),
																														        ('000004', 'Joseph JoJo', '712-321-948', 'NotSilve@gmail.com', 'Mario@gmail.com'),
																															        ('000005', 'Josephine', '722-121-948', 'Josephine@gmail.com', 'SaintLouis@gmail.com');

																																INSERT INTO COUPLE (CoupleID, HeaCCard, FatherID) VALUES
																																        ('1000001', 'HeaCard001', NULL),
																																	        ('1000002', 'HeaCard001', 'Father001'),
																																		        ('1000003', 'HeaCard002', NULL),
																																			        ('1000004', 'HeaCard004', 'Father002'),
																																				        ('1000005', 'HeaCard005', NULL);

																																					INSERT INTO Appointment (AppointmentID, ADate, ATime, CoupleID, PracID) VALUES
																																					        ('Appoint001', '2021-03-02', '07:00', '1000001', '000001'),
																																						        ('Appoint002', '2022-03-22', '11:00', '1000001', '000002'),
																																							        ('Appoint003', '2022-03-22', '11:00', '1000002', '000002'),
																																								        ('Appoint004', '2022-03-24', '13:03', '1000003', '000001'),
																																									        ('Appoint005', '2022-03-23', '12:00', '1000004', '000002');

																																										INSERT INTO Website (URL) VALUES
																																										        ('00001'),
																																											        ('00002'),
																																												        ('00003'),
																																													        ('00004'),
																																														        ('00005');

																																															INSERT INTO CoupleSign (CoupleID, URL) VALUES
																																															        ('1000001', '00001'),
																																																        ('1000002', '00002'),
																																																	        ('1000003', '00003'),
																																																		        ('1000004', '00004'),
																																																			        ('1000005', '00005');

																																																				INSERT INTO Pregnancy (FinalEstDate, NewEstDate, BirthTime, InitialEstDate, PregID, NumofPreg, homeBirth, IEmail, CoupleID, PracID, BackUpID) VALUES
																																																				        (NULL, NULL, NULL,'1998-10-01', 'Preg001', 2, TRUE, 'Mario4@gmail.com', '1000005', '000002', NULL),
																																																					        ('2021-01-02', '2021-01-02', '02:00', '2021-01-01', 'Preg002', 1, TRUE, 'Mario3@gmail.com', '1000005', '000002', NULL),
																																																						        ('2022-07-02', '2021-07-02', '02:00', '2021-01-01', 'Preg003', 1, TRUE, 'Mario2@gmail.com', '1000004', '000004', NULL),
																																																							        (NULL, NULL, '02:00', '2022-07-03', 'Preg004', 1, TRUE, 'Mario@gmail.com', '1000003', '000004', NULL),
																																																								        ('2022-07-03', '2021-07-03', '02:00', '2021-04-01', 'Preg005', 1, TRUE, 'Mario2@gmail.com', '1000003', '000005', NULL),
																																																									        (NULL, '2021-01-01', '02:00', '2021-01-01', 'Preg006', 1, TRUE, 'Mario2@gmail.com', '1000003', '000005', NULL),
																																																										        ('2022-07-08', '2021-07-03', '02:00', '2021-04-01', 'Preg007', 1, TRUE, 'Mario2@gmail.com', '1000002', '000005', NULL);                                                                                                                                           ;
																																																											INSERT INTO Notes (AppointmentID, content, Stime, SDate, NID, PracID, PregID) VALUES
																																																											    ('Appoint005', 'AB', '3:00', '2022-03-24', 'Note001', '000001', 'Preg001'),
																																																											    ('Appoint005', 'AB', '4:00', '2022-03-24', 'Note002', '000001', 'Preg001'),
																																																											    ('Appoint005', 'AB', '3:00', '2022-04-24', 'Note003', '000001', 'Preg001'),
																																																											    ('Appoint005', 'AB', '3:00', '2022-05-24', 'Note004', '000001', 'Preg001'),
																																																											    ('Appoint005', 'AB', '4:00', '2022-06-24', 'Note005', '000001', 'Preg001');

																																																											INSERT INTO INFOSESSION (InfoID, language, Sdate, Stime, PracID) VALUES
																																																											        ('10000001', 'English', '2021-03-22', '06:00', '000001'),
																																																												        ('10000002', 'German', '2022-03-22', '07:00', '000002'),
																																																													        ('10000003', 'English', '2021-03-22', '08:00', '000002'),
																																																														        ('10000004', 'Mexician', '2022-04-22', '07:00', '000002'),
																																																															        ('10000005', 'Chinese', '2022-03-22', '07:00', '000001');

																																																																INSERT INTO ASSIGN (CoupleID, InfoID, Attended) VALUES
																																																																        ('1000001', '10000001', TRUE),
																																																																	        ('1000002', '10000001', FALSE),
																																																																		        ('1000003', '10000002', TRUE),
																																																																			        ('1000004', '10000003', TRUE),
																																																																				        ('1000002', '10000005', TRUE);

																																																																					INSERT INTO WEBPARTNER (IEmail, URL) VALUES
																																																																					        ('Cisco@Gmail.com', '00001'),
																																																																						        ('Mario4@gmail.com', '00002'),
																																																																							        ('Mario3@gmail.com', '00003'),
																																																																								        ('Mario2@gmail.com','00004'),
																																																																									        ('Mario@gmail.com', '00005');

																																																																										INSERT INTO Test (TestID, Type, PrecDate, sampleTestDate, LabDate, Result, TechID, PracID, PregID) VALUES
																																																																										        ('Test001', 'blood iron', '2021-01-02', NULL, NULL, 'Not yet teseted', 'Tech001', '000001', 'Preg001'),
																																																																											        ('Test002', 'blood iron', '2021-01-03', '2021-01-04', '2021-01-05', 'Negative', 'Tech002', '000002', 'Preg002'),
																																																																												        ('Test003', 'blood iron', '2021-01-02', '2021-01-04', NULL, 'Two days later..Negative?', 'Tech001', '000001', 'Preg001'),
																																																																													        ('Test004', 'blood iron', '2021-01-02', '2021-01-04', '2021-01-06', 'Negative Indeed', 'Tech001', '000001', 'Preg001'),
																																																																														        ('Test005', 'blood iron', '2021-01-03', '2021-01-04', '2021-01-05', 'Negative', 'Tech002', '000002', 'Preg003');

																																																																															INSERT INTO BABY (BabyID, PregID, gender, dob, btime, BloodType, bname) VALUES
																																																																															        ('Baby001', 'Preg001', 'Male', NULL, NULL, NULL, 'Joseph'),
																																																																																        ('Baby002', 'Preg001', 'Male', NULL, NULL, NULL, 'Jacob'),
																																																																																	        ('Baby003', 'Preg002', 'Female', '2021-01-01', '02:00', NULL, 'Luke'),
																																																																																		        ('Baby004', 'Preg003', 'Male', '2021-07-02', '02:00', NULL, 'Leo'),
																																																																																			        ('Baby005', 'Preg004', 'Male', '2022-07-03', '04:00', NULL, 'Scott'),
																																																																																				        ('Baby006', 'Preg005', 'Female', '2021-07-03', '02:00', NULL, 'Zack'),
																																																																																					        ('Baby007', 'Preg006', 'Male', '2021-01-01', '02:00', NULL, 'Losan'),
																																																																																						        ('Baby008', 'Preg006', 'Male', '2021-01-01', '03:00', NULL, 'Logan');

