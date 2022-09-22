CREATE DATABASE edudb encoding utf8;

\c edudb;

CREATE TABLE IF NOT EXISTS hocsinh(
    mssv INTEGER PRIMARY KEY,
    username varchar(255) UNIQUE NOT NULL,
    password varchar(255) NOT NULL,
    name varchar(255) NOT NULL,
    dob date NOT NULL,
    sex boolean NOT NULL,
    address varchar(255) NOT NULL,
    quequan varchar(255) NOT NULL,
    phone varchar(255) NOT NULL,
    email varchar(255) NOT NULL
);
CREATE TABLE IF NOT EXISTS giaovien(
    msgv INTEGER PRIMARY KEY,
    username varchar(255) UNIQUE NOT NULL,
    password varchar(255) NOT NULL,
    name varchar(255) NOT NULL,
    dob date NOT NULL,
    sex boolean NOT NULL,
    address varchar(255) NOT NULL,
    quequan varchar(255) NOT NULL,
    phone varchar(255) NOT NULL,
    email varchar(255) NOT NULL
);
CREATE TABLE IF NOT EXISTS lophoc(
    phonghoc varchar(255) PRIMARY KEY
);


CREATE TABLE IF NOT EXISTS monhoc(
    mamonhoc varchar(255) PRIMARY KEY,
    tenmonhoc varchar(255) NOT NULL,
    sotinchi INTEGER NOT NULL,
    thoiluong INTEGER NOT NULL
);
CREATE TABLE IF NOT EXISTS monday(
    mamonhoc varchar(255) NOT NULL,
    msgv INTEGER NOT NULL,
    foreign key(mamonhoc) references monhoc(mamonhoc),
    foreign key(msgv) references giaovien(msgv),
    PRIMARY KEY(mamonhoc,msgv)
);


 
CREATE TABLE IF NOT EXISTS lop(
    class_id serial PRIMARY KEY,
    mamonhoc varchar(255) NOT NULL,
    msgv INTEGER NOT NULL,
    giohoc time,
    ngaytrongtuan INTEGER,
    namhoc INTEGER NOT NULL DEFAULT date_part('year',CURRENT_DATE);
    kyhoc INTEGER NOT NULL DEFAULT date_part('month',CURRENT_DATE)/4,
    phonghoc varchar(255) NOT NULL,
    status boolean not null default true,
    foreign key(mamonhoc) references monhoc(mamonhoc),
    foreign key(msgv) references giaovien(msgv),
    foreign key phonghoc references lophoc(phonghoc)
);


CREATE TABLE IF NOT EXISTS dangky(
    mssv INTEGER NOT NULL,
    class_id INTEGER NOT NULL,
    foreign key(mssv) references hocsinh(mssv),
    foreign key(class_id) references lop(class_id),
    PRIMARY KEY(mssv,class_id)
);
CREATE TABLE IF NOT EXISTS baikiemtra(
    test_id serial PRIMARY KEY,
    class_id INTEGER NOT NULL,
    mssv INTEGER NOT NULL,
    diemgiuaky float ,
    diemcuoiky float,
    foreign key(class_id) references lop(class_id),
    foreign key(mssv) references hocsinh(mssv) 
);

CREATE OR REPLACE FUNCTION checkstatus() RETURNS TRIGGER
AS $$
BEGIN
    IF (select count(mssv) from lop left join dangky on lop.class_id = dangky.class_id WHERE lop.class_id = NEW.class_id group by lop.class_id  ) >= 30 
    THEN 
        UPDATE lop SET status = false where class_id = NEW.class_id;
        RETURN OLD;
    END IF;
    RETURN NEW;
END;
$$ language plpgsql;

CREATE OR REPLACE TRIGGER check_status AFTER INSERT ON dangky
FOR EACH ROW
EXECUTE PROCEDURE checkstatus();

CREATE OR REPLACE FUNCTION addclass() RETURNS TRIGGER
AS $$
BEGIN
    INSERT INTO baikiemtra(mssv,class_id) VALUES (NEW.mssv,NEW.class_id);
    RETURN NEW;
END;
$$ language plpgsql;

CREATE OR REPLACE TRIGGER addclass AFTER INSERT ON dangky
FOR EACH ROW
EXECUTE PROCEDURE addclass();

CREATE OR REPLACE FUNCTION delclass() RETURNS TRIGGER
AS $$
BEGIN
    DELETE FROM baikiemtra WHERE class_id = OLD.class_id AND mssv = OLD.mssv;
    RETURN NEW;
END;
$$ language plpgsql;

CREATE OR REPLACE TRIGGER delclass AFTER DELETE ON dangky
FOR EACH ROW
EXECUTE PROCEDURE delclass();

insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20200995, 'fdeshorts0', 'Hg9nW86', 'Fredericka Deshorts', '2002/01/12', true, '30218 Logan Junction', '777 Straubel Hill', '241-415-4087', 'fdeshorts0@hhs.gov');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20203653, 'mjohncey0', '7mFbpv7d0o', 'Magdalene Johncey', '2002/03/25', true, '94008 Eggendart Alley', '35 Drewry Crossing', '602-592-7750', 'mjohncey0@microsoft.com');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20203000, 'hvaggs1', 'XoDPOzS', 'Herbert Vaggs', '2002/03/11', true, '99589 Welch Avenue', '36 Brentwood Street', '768-631-9492', 'hvaggs1@reverbnation.com');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20204168, 'dmayhou2', '8KnYgNq', 'Demetria Mayhou', '2002/04/13', false, '625 Vidon Way', '47405 Columbus Trail', '244-661-1144', 'dmayhou2@kickstarter.com');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20200396, 'kchestnut3', 'jb9NC63d', 'Keslie Chestnut', '2002/03/08', false, '3 Bunker Hill Junction', '596 Harper Place', '600-799-5903', 'kchestnut3@51.la');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20202739, 'mchark4', 'M5Pvt8KO7', 'Mortimer Chark', '2002/03/06', false, '72386 Dryden Crossing', '82484 Weeping Birch Street', '903-769-6360', 'mchark4@sakura.ne.jp');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20203937, 'jterrill5', 'YJrRDB2', 'Jillane Terrill', '2002/01/06', false, '15923 Susan Hill', '50 Merry Point', '164-730-2530', 'jterrill5@wired.com');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20204372, 'vberthel6', 'lV7mtF', 'Vincent Berthel', '2002/03/28', true, '7 Gulseth Circle', '9816 Crest Line Street', '747-922-9427', 'vberthel6@biblegateway.com');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20205620, 'cmaccarter7', '48rvkkpS', 'Cristy MacCarter', '2002/01/28', false, '87027 Village Green Plaza', '881 Southridge Parkway', '953-400-3967', 'cmaccarter7@dailymotion.com');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20204358, 'osheryne8', 'VsoESCE', 'Odella Sheryne', '2002/03/22', false, '9 Gulseth Hill', '3 Sunfield Park', '918-720-4017', 'osheryne8@sakura.ne.jp');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20204210, 'pelijah9', 'jThKRhD', 'Pat Elijah', '2002/03/08', false, '3 Gerald Crossing', '928 Blue Bill Park Pass', '905-174-9538', 'pelijah9@naver.com');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20200884, 'dduprea', '5VwPQoDRK5', 'Drucill Dupre', '2002/03/20', true, '0 Warrior Terrace', '4 Hallows Hill', '772-682-7550', 'dduprea@samsung.com');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20203441, 'hpettyfarb', 'IJatcHXQ1', 'Herb Pettyfar', '2002/03/30', true, '5 Mayfield Pass', '3 Manufacturers Terrace', '851-445-7071', 'hpettyfarb@deliciousdays.com');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20200337, 'pbickleyc', 'sp6o1cWPbHC', 'Petunia Bickley', '2002/02/18', true, '25505 Boyd Drive', '67 Golden Leaf Place', '684-661-6198', 'pbickleyc@wikipedia.org');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20201400, 'eayrisd', 'qzzB5h', 'Ertha Ayris', '2002/04/26', false, '0 Alpine Lane', '2 Lake View Road', '505-980-4390', 'eayrisd@theatlantic.com');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20200199, 'psanderse', 'k9Cci0IymnZ', 'Perry Sanders', '2002/03/19', false, '07 Judy Park', '65 Sauthoff Junction', '922-671-3611', 'psanderse@yellowbook.com');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20200791, 'abricef', 'bKmw4Y4IhUt', 'Avram Brice', '2002/01/23', true, '44945 Bayside Court', '8996 Ridgeway Terrace', '954-169-0098', 'abricef@netlog.com');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20205798, 'ndewickeg', 'Qy5Fkc', 'Nick Dewicke', '2002/03/02', true, '83 Maryland Point', '12836 Brown Center', '309-999-6173', 'ndewickeg@europa.eu');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20201744, 'mtowllh', '3iOkMgu', 'Melisse Towll', '2002/03/02', false, '7652 Marquette Park', '63 Melby Road', '708-371-1823', 'mtowllh@mysql.com');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20203269, 'cdeehani', 'tMhhw1ca9a', 'Cori Deehan', '2002/03/20', false, '14192 Manufacturers Street', '487 Transport Pass', '238-253-0943', 'cdeehani@earthlink.net');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20202424, 'fduntonj', 'OZMJD0ox8FkJ', 'Franklin Dunton', '2002/03/24', true, '919 Hovde Junction', '9175 Fair Oaks Street', '773-930-4863', 'fduntonj@discovery.com');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20200508, 'dstearnsk', 'Sx2B71O6a', 'Delainey Stearns', '2002/04/26', false, '3110 Manufacturers Drive', '64363 Arrowood Place', '362-743-0002', 'dstearnsk@sohu.com');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20202945, 'kvaughanhughesl', 'XfXwxznE7', 'Koral Vaughan-Hughes', '2002/01/27', true, '5667 Forster Park', '32312 Grim Way', '105-490-5096', 'kvaughanhughesl@house.gov');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20203397, 'epulferm', 'euv66IpQ', 'Evey Pulfer', '2002/01/09', false, '6 Old Shore Alley', '348 Waywood Place', '141-836-0738', 'epulferm@shop-pro.jp');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20201263, 'ddumken', 'Q0QuoJBc', 'Diena Dumke', '2002/04/03', false, '3236 Surrey Terrace', '7 Utah Hill', '125-791-3576', 'ddumken@hibu.com');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20201945, 'emaciluricko', '29oZJY', 'Edmund MacIlurick', '2002/03/12', true, '1 Sachs Alley', '67611 Bashford Parkway', '738-121-7009', 'emaciluricko@posterous.com');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20205703, 'nbowndep', '6NZblhL', 'Natka Bownde', '2002/01/26', false, '6964 Surrey Trail', '13 Arkansas Trail', '934-855-3671', 'nbowndep@answers.com');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20205724, 'thenrionotq', 'uB9ruWnRoVa', 'Tris Henrionot', '2002/03/21', true, '42 School Place', '398 Spohn Hill', '808-796-4224', 'thenrionotq@ftc.gov');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20205612, 'tstarmontr', 'QoL0IQN8', 'Ted Starmont', '2002/03/24', false, '35010 Larry Junction', '3 Bluejay Plaza', '119-256-3757', 'tstarmontr@theguardian.com');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20200673, 'arosternes', 'RzGWxMmgr', 'Addia Rosterne', '2002/04/23', false, '6963 Stone Corner Hill', '4383 Surrey Way', '399-607-8212', 'arosternes@naver.com');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20204517, 'gsvanettit', 'unLUtQVZwx', 'Giulia Svanetti', '2002/05/08', false, '45 7th Place', '831 Fieldstone Drive', '788-850-0658', 'gsvanettit@uiuc.edu');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20203788, 'lliveleyu', 'kaRjmSA', 'Lee Liveley', '2002/03/16', false, '2998 Farwell Junction', '23047 Nevada Hill', '422-843-2331', 'lliveleyu@squarespace.com');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20201818, 'dridsdalev', '6ODK1cPcMW5', 'Dayle Ridsdale', '2002/03/28', true, '87 Rutledge Terrace', '207 Westridge Junction', '737-724-7605', 'dridsdalev@ibm.com');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20203751, 'jcrumlyw', 'ZgDf1eOoWX', 'Jean Crumly', '2002/03/09', false, '6435 Shopko Way', '070 Fulton Lane', '676-555-8223', 'jcrumlyw@uiuc.edu');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20201875, 'scamilix', 'drkK76', 'Salome Camili', '2002/01/16', false, '4057 Prentice Junction', '4449 Service Terrace', '413-814-3312', 'scamilix@walmart.com');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20203422, 'jcouthardy', 'T73MuUhJM1E', 'Joelie Couthard', '2002/04/17', true, '9908 Kennedy Hill', '292 Jenna Hill', '917-577-9073', 'jcouthardy@posterous.com');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20200813, 'gollez', 'jCQcST', 'Gordan Olle', '2002/02/01', false, '661 Moose Court', '08216 Packers Park', '168-964-4555', 'gollez@howstuffworks.com');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20204327, 'lfanshaw10', 'cHIN9OtYBlc', 'Liane Fanshaw', '2002/03/02', false, '88 Sauthoff Junction', '8211 Continental Pass', '487-893-6854', 'lfanshaw10@nymag.com');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20200866, 'mclaxson11', '6T2qgfb7Jwj', 'Modestine Claxson', '2002/01/20', false, '81 Butterfield Center', '3988 Corben Junction', '924-719-9578', 'mclaxson11@who.int');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20202909, 'emole12', '8VUFPHf', 'Eustacia Mole', '2002/04/22', false, '82664 Mesta Park', '782 Mosinee Center', '509-123-4678', 'emole12@businessweek.com');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20201845, 'lwipfler13', '2vzvqP4twuB1', 'Leopold Wipfler', '2002/01/07', true, '43 Veith Street', '29256 Dahle Hill', '106-395-1739', 'lwipfler13@cbsnews.com');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20204239, 'rduckerin14', 'hxl8tR0Qjs', 'Rhys Duckerin', '2002/03/24', false, '810 Kipling Terrace', '048 Green Center', '859-113-3292', 'rduckerin14@rambler.ru');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20205781, 'cbrigg15', '8fDVx8Ioxx', 'Chevalier Brigg', '2002/05/11', true, '9 Florence Crossing', '41160 Lyons Trail', '808-175-6826', 'cbrigg15@hibu.com');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20202557, 'sgavriel16', 'NJ41W5y7', 'Sari Gavriel', '2002/01/15', false, '295 Roth Parkway', '965 Del Sol Place', '806-243-1368', 'sgavriel16@seesaa.net');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20202707, 'shehir17', 'MTTjkZW', 'Saloma Hehir', '2002/02/08', false, '5 Lyons Alley', '5220 Carpenter Lane', '487-389-7636', 'shehir17@admin.ch');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20203135, 'shemphill18', 'DC8bYRWiliv', 'Sarena Hemphill', '2002/01/07', false, '06 Morning Court', '6956 West Point', '706-248-7423', 'shemphill18@sciencedirect.com');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20201617, 'enapolitano19', 'kEg4IheirbNa', 'Edythe Napolitano', '2002/01/24', false, '19 Declaration Center', '777 Lakeland Road', '322-296-4095', 'enapolitano19@ask.com');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20201514, 'eguise1a', '02AzSIFRcLv', 'Esma Guise', '2002/04/21', false, '9 Kings Drive', '76 Sommers Court', '685-108-0691', 'eguise1a@angelfire.com');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20204887, 'fthorsby1b', 'xbBsLEEy', 'Faythe Thorsby', '2002/01/07', true, '75690 Florence Park', '407 Declaration Hill', '498-721-9970', 'fthorsby1b@smugmug.com');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20202165, 'thoff1c', 'mSe4JF5E', 'Tabina Hoff', '2002/01/27', true, '29479 Schlimgen Point', '7 Forest Run Center', '510-940-9949', 'thoff1c@google.ru');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20205174, 'ktrainor1d', 'xdFzGbUKCAP', 'Katie Trainor', '2002/02/01', false, '2545 Sachs Lane', '25 Elmside Way', '617-547-8660', 'ktrainor1d@earthlink.net');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20203637, 'bkehri1e', '13eJWp', 'Brant Kehri', '2002/03/21', true, '7 American Drive', '768 Aberg Drive', '873-778-0526', 'bkehri1e@goo.gl');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20202172, 'pantrim1f', 'K2D5NH', 'Pate Antrim', '2002/02/20', false, '46506 Red Cloud Crossing', '6 Hoard Lane', '605-795-6506', 'pantrim1f@yellowpages.com');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20200690, 'emcclarence1g', 'odIWlo', 'Ericha McClarence', '2002/01/09', false, '2691 Clemons Center', '0096 6th Avenue', '858-234-1641', 'emcclarence1g@gov.uk');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20203696, 'mdolden1h', '4TIMNe2DuO', 'Myrilla Dolden', '2002/02/02', false, '20883 Ilene Court', '40 Mosinee Lane', '273-660-8966', 'mdolden1h@phoca.cz');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20205848, 'bmarklow1i', 'M6o1Jnm', 'Berti Marklow', '2002/03/14', true, '120 Clemons Parkway', '6980 School Street', '241-553-8424', 'bmarklow1i@amazonaws.com');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20202407, 'vbronger1j', 'sScYgqN46K', 'Vassili Bronger', '2002/02/25', true, '0707 8th Way', '73840 Stone Corner Avenue', '344-744-6528', 'vbronger1j@boston.com');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20204801, 'wmacdavitt1k', 'hC8n7Bn', 'Wolfgang MacDavitt', '2002/02/08', false, '6684 Schmedeman Place', '53 Duke Park', '615-513-3414', 'wmacdavitt1k@europa.eu');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20201773, 'jsheals1l', 'Rl9sqpO', 'Jenilee Sheals', '2002/02/01', false, '53 Fairfield Alley', '35 Hazelcrest Pass', '256-884-3959', 'jsheals1l@senate.gov');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20201227, 'sclarycott1m', '8Lu6ZcyQYeIl', 'Sisile Clarycott', '2002/01/21', true, '70001 Debra Place', '6 Little Fleur Pass', '197-403-6538', 'sclarycott1m@hexun.com');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20205160, 'jrusse1n', 'F8DklL', 'Julie Russe', '2002/05/07', true, '8215 Shasta Road', '739 John Wall Center', '109-424-1148', 'jrusse1n@google.nl');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20202866, 'lloseke1o', 'i5bRsqF9cGt8', 'Lorita Loseke', '2002/03/20', true, '279 Ludington Alley', '90938 Old Gate Drive', '656-409-2688', 'lloseke1o@exblog.jp');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20202307, 'bjankovsky1p', 'WyGpMmq', 'Burke Jankovsky', '2002/02/16', true, '0600 Esker Drive', '08393 Chinook Way', '183-478-9994', 'bjankovsky1p@typepad.com');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20205583, 'mchainey1q', 'zl4D0P', 'Melanie Chainey', '2002/02/28', true, '66 Porter Pass', '568 Meadow Vale Park', '582-113-1961', 'mchainey1q@marriott.com');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20201867, 'ade1r', 'YrgVKJY1kH', 'Ardine De Marchi', '2002/03/02', true, '74739 Maryland Hill', '724 Killdeer Court', '280-944-4352', 'ade1r@slideshare.net');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20205868, 'bsquibe1s', 'tIyk5Sv63KEO', 'Bevon Squibe', '2002/04/04', false, '7530 North Street', '08 Nevada Way', '841-775-1981', 'bsquibe1s@seesaa.net');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20202671, 'jgotch1t', 'G06sJYAEl80t', 'Jemimah Gotch', '2002/02/22', false, '10358 Fisk Terrace', '8 Oak Valley Center', '247-539-8261', 'jgotch1t@ft.com');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20200481, 'aheugle1u', 'CD9jfVpxNf4', 'Alethea Heugle', '2002/01/24', true, '42677 Scoville Point', '2655 Fordem Place', '470-946-6579', 'aheugle1u@yellowpages.com');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20201672, 'gcridge1v', 'CxYLfkM7dVN', 'Gusta Cridge', '2002/05/02', true, '13500 Duke Park', '877 Ohio Road', '898-561-7670', 'gcridge1v@alibaba.com');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20201158, 'pgoldhill1w', 'OLdEyIJ', 'Parrnell Goldhill', '2002/01/04', false, '50 Vernon Terrace', '201 Milwaukee Road', '767-354-7081', 'pgoldhill1w@creativecommons.org');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20200942, 'bdulanty1x', '42Dqwc', 'Blanche Dulanty', '2002/02/13', true, '9910 Hanson Way', '57 American Ash Circle', '514-369-4313', 'bdulanty1x@unblog.fr');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20200249, 'fgiannini1y', 'FkRXySF0EIC1', 'Freemon Giannini', '2002/02/21', false, '51593 Garrison Junction', '525 Troy Drive', '931-791-8794', 'fgiannini1y@skyrock.com');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20203179, 'fbraams1z', 'uZBd9v68', 'Fan Braams', '2002/01/15', false, '6 Chinook Drive', '6 Bonner Alley', '359-580-7158', 'fbraams1z@blog.com');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20202802, 'mblanket20', 'hzkodkMctwN', 'Melicent Blanket', '2002/04/11', false, '7001 North Drive', '4 Scoville Alley', '123-939-6865', 'mblanket20@freewebs.com');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20201829, 'csearle21', '3fIVRljrmYx', 'Celestyn Searle', '2002/01/10', false, '5859 Melrose Alley', '5 Calypso Parkway', '266-974-6345', 'csearle21@hibu.com');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20203274, 'dhavelin22', 'NH0zGEf', 'Dani Havelin', '2002/02/26', false, '32 Steensland Junction', '9 Debs Hill', '269-702-4059', 'dhavelin22@dell.com');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20203691, 'ebarabisch23', 'Ds04gizf', 'Estele Barabisch', '2002/04/15', true, '4 Hanover Point', '30634 Lakewood Hill', '229-487-1619', 'ebarabisch23@apache.org');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20205425, 'cfinlow24', 't7UKltKT', 'Charil Finlow', '2002/03/12', false, '7273 7th Way', '028 Vahlen Court', '249-949-4415', 'cfinlow24@hao123.com');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20200183, 'ccathro25', 'eVMD0U', 'Cybil Cathro', '2002/03/07', true, '02058 Hermina Alley', '7 Eagle Crest Place', '167-952-1042', 'ccathro25@cnet.com');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20201192, 'rcrosthwaite26', 'Mh9tGA', 'Reinaldo Crosthwaite', '2002/01/14', true, '657 South Junction', '377 Oakridge Circle', '903-337-6185', 'rcrosthwaite26@illinois.edu');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20200614, 'rleeson27', 'HZosApFzD', 'Raul Leeson', '2002/03/31', false, '8377 Ilene Street', '0 Lotheville Court', '197-381-0624', 'rleeson27@uol.com.br');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20205429, 'mgoldstraw28', '3C3njrT', 'Mariquilla Goldstraw', '2002/02/28', false, '95 Bartillon Trail', '59936 Sunnyside Parkway', '766-185-6867', 'mgoldstraw28@de.vu');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20204613, 'eklimkov29', 'uwalfC1eIo1', 'Egan Klimkov', '2002/05/05', true, '06040 New Castle Drive', '0920 Loftsgordon Drive', '417-454-7540', 'eklimkov29@gov.uk');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20202694, 'gculter2a', 'jKwtNtc33k', 'Gayle Culter', '2002/03/10', false, '9049 Judy Center', '74745 Springview Parkway', '373-936-7687', 'gculter2a@guardian.co.uk');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20203761, 'jde2b', 'kElUbU', 'Joelly De Hooge', '2002/02/13', true, '5 Blaine Drive', '21 Oxford Terrace', '602-968-7450', 'jde2b@live.com');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20202674, 'gnaulty2c', 'PUZ81R', 'Glennis Naulty', '2002/01/17', false, '94583 Orin Street', '0 Morning Park', '354-998-8033', 'gnaulty2c@hubpages.com');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20205753, 'mkulic2d', '7Y8pGQARe1Sp', 'Marylinda Kulic', '2002/02/26', false, '6805 Dapin Circle', '4809 Forest Dale Hill', '838-499-3684', 'mkulic2d@prnewswire.com');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20201230, 'dpereira2e', 'BtHuO7JZIQR', 'Dominica Pereira', '2002/05/11', false, '64162 Dovetail Way', '7 Dakota Alley', '984-393-9966', 'dpereira2e@state.gov');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20204702, 'dzanussii2f', '81LrYR', 'Donielle Zanussii', '2002/03/25', false, '0 8th Drive', '7048 Melrose Lane', '811-264-7668', 'dzanussii2f@toplist.cz');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20204097, 'mpantling2g', 'xq2U461O', 'Myrvyn Pantling', '2002/01/03', false, '15 Riverside Lane', '35145 Westridge Hill', '892-189-1250', 'mpantling2g@nsw.gov.au');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20205590, 'ebrade2h', 'jfVKBDl', 'Emalia Brade', '2002/04/09', false, '90 Monica Trail', '051 Katie Alley', '773-544-4680', 'ebrade2h@go.com');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20200486, 'dyoungman2i', 'eXeWrFFRi', 'Demetris Youngman', '2002/03/23', true, '16561 Tony Place', '619 Lawn Court', '929-532-6945', 'dyoungman2i@google.fr');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20204993, 'jstronough2j', '5Q1HeLlNTYFX', 'Jack Stronough', '2002/01/17', false, '73800 Coleman Avenue', '38 Summer Ridge Plaza', '738-993-6611', 'jstronough2j@nih.gov');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20203094, 'edenniss2k', 'WmjZeS', 'Ella Denniss', '2002/04/29', false, '8 Charing Cross Way', '114 Mallard Court', '375-249-2585', 'edenniss2k@hatena.ne.jp');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20202547, 'ntombleson2l', 'WbqdKlrRn8', 'Netta Tombleson', '2002/01/11', false, '38343 Victoria Court', '7 Hudson Avenue', '751-110-5175', 'ntombleson2l@yahoo.co.jp');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20205641, 'ksanders2m', '1Rvu9k', 'Kelsey Sanders', '2002/04/05', false, '59 Cherokee Trail', '17 Nobel Trail', '425-688-0775', 'ksanders2m@samsung.com');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20205285, 'ndansken2n', 'NwXcCOYBC', 'Nara Dansken', '2002/02/16', true, '0289 Derek Point', '9305 Gulseth Trail', '754-999-4887', 'ndansken2n@goo.gl');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20200989, 'amelbury2o', 'CRDpQG71', 'Adda Melbury', '2002/02/24', false, '2950 Johnson Trail', '4 Dexter Park', '106-896-5932', 'amelbury2o@github.io');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20203478, 'torman2p', 'gMFhLD6e0C5', 'Terrijo Orman', '2002/03/30', true, '80 Express Alley', '392 Elgar Trail', '622-879-8167', 'torman2p@xing.com');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20202180, 'jmcgrorty2q', 'YIlzMnUj2SqJ', 'Josselyn McGrorty', '2002/04/13', false, '18 Service Terrace', '4852 Roth Street', '639-217-4522', 'jmcgrorty2q@weebly.com');
insert into hocsinh (mssv, username, password, name, dob, sex, address, quequan, phone, email) values (20203671, 'rbrotherwood2r', 'Kb8Ra8lvB', 'Rosie Brotherwood', '2002/04/26', true, '652 Clemons Center', '02855 Anderson Road', '660-642-1670', 'rbrotherwood2r@skyrock.com');



insert into giaovien (msgv, username, password, name, dob, sex, address, quequan, phone, email) values (19992708, 'cglendinning0', 'Rc5b2GXJrh', 'Christabel Glendinning', '2002/01/21', false, '5850 Fremont Street', '15283 Elka Alley', '751-972-3993', 'cglendinning0@privacy.gov.au');
insert into giaovien (msgv, username, password, name, dob, sex, address, quequan, phone, email) values (19992966, 'hchaffin1', '4SCPpNWhjWwc', 'Hasheem Chaffin', '2002/05/02', false, '17311 Morrow Street', '131 Oak Avenue', '785-268-2422', 'hchaffin1@ezinearticles.com');
insert into giaovien (msgv, username, password, name, dob, sex, address, quequan, phone, email) values (19994082, 'pgalland2', '8nGhcDjY', 'Perrine Galland', '2002/02/20', true, '96209 Parkside Junction', '60 Onsgard Lane', '925-204-8017', 'pgalland2@diigo.com');
insert into giaovien (msgv, username, password, name, dob, sex, address, quequan, phone, email) values (19992054, 'twoodrup3', 'DCTaeX8IHc', 'Travers Woodrup', '2002/04/06', false, '76193 Emmet Way', '654 Wayridge Avenue', '922-949-4772', 'twoodrup3@hubpages.com');
insert into giaovien (msgv, username, password, name, dob, sex, address, quequan, phone, email) values (19993669, 'sglazebrook4', 'FF2mOomCWC3', 'Sonny Glazebrook', '2002/01/28', true, '2366 Dixon Center', '55 Beilfuss Parkway', '803-472-8322', 'sglazebrook4@artisteer.com');
insert into giaovien (msgv, username, password, name, dob, sex, address, quequan, phone, email) values (19991720, 'cshortin5', 'zCJWPm08', 'Christine Shortin', '2002/04/13', true, '78 Carioca Junction', '57 Atwood Avenue', '802-696-3055', 'cshortin5@bbc.co.uk');
insert into giaovien (msgv, username, password, name, dob, sex, address, quequan, phone, email) values (19991722, 'tcollicott6', '2o5KXRWN3I', 'Terra Collicott', '2002/02/15', true, '604 Lighthouse Bay Center', '2441 High Crossing Junction', '554-834-4134', 'tcollicott6@icio.us');
insert into giaovien (msgv, username, password, name, dob, sex, address, quequan, phone, email) values (19991200, 'tbazley7', 'qtPFo3R', 'Teddy Bazley', '2002/01/27', true, '4046 Brown Alley', '168 Loftsgordon Parkway', '621-939-2479', 'tbazley7@hatena.ne.jp');
insert into giaovien (msgv, username, password, name, dob, sex, address, quequan, phone, email) values (19995155, 'whelleker8', 'khmlsX', 'Winthrop Helleker', '2002/01/17', true, '07709 Fallview Court', '69 Iowa Trail', '468-302-9325', 'whelleker8@surveymonkey.com');
insert into giaovien (msgv, username, password, name, dob, sex, address, quequan, phone, email) values (19993913, 'chavesides9', '7ivBvKt0D', 'Cecilla Havesides', '2002/04/08', false, '333 Anthes Pass', '627 Surrey Pass', '629-173-5145', 'chavesides9@typepad.com');
insert into giaovien (msgv, username, password, name, dob, sex, address, quequan, phone, email) values (19991777, 'abuckea', 'zoXBqpuK9L', 'Adria Bucke', '2002/03/04', true, '91 8th Hill', '34 La Follette Lane', '931-924-9643', 'abuckea@usnews.com');
insert into giaovien (msgv, username, password, name, dob, sex, address, quequan, phone, email) values (19994293, 'abroseb', 'kl07p3s', 'Abbe Brose', '2002/03/15', true, '8534 Farragut Plaza', '386 Sloan Junction', '145-686-3605', 'abroseb@nature.com');
insert into giaovien (msgv, username, password, name, dob, sex, address, quequan, phone, email) values (19990613, 'smcinallyc', 'ipREdbno7', 'Sadye McInally', '2002/01/17', false, '4 Tennyson Drive', '64943 Nancy Terrace', '725-269-9423', 'smcinallyc@chicagotribune.com');
insert into giaovien (msgv, username, password, name, dob, sex, address, quequan, phone, email) values (19994767, 'cpowlandd', 'GkFNC4MG8', 'Caren Powland', '2002/04/02', true, '52 Grayhawk Hill', '33 Knutson Street', '733-747-2498', 'cpowlandd@berkeley.edu');
insert into giaovien (msgv, username, password, name, dob, sex, address, quequan, phone, email) values (19992701, 'mquilkine', 'GlGHNCb4I', 'Mallory Quilkin', '2002/05/04', true, '89 Helena Drive', '663 Lien Point', '969-960-5592', 'mquilkine@mapy.cz');
insert into giaovien (msgv, username, password, name, dob, sex, address, quequan, phone, email) values (19992848, 'cdomelowf', 'y7eQaTX', 'Corbet Domelow', '2002/02/17', true, '5 Fairfield Street', '62 Sommers Point', '116-818-8517', 'cdomelowf@simplemachines.org');
insert into giaovien (msgv, username, password, name, dob, sex, address, quequan, phone, email) values (19994431, 'awestmoreg', 'bryWNJrY', 'Alanna Westmore', '2002/01/08', true, '789 Scott Junction', '817 Mockingbird Pass', '316-967-3893', 'awestmoreg@chronoengine.com');
insert into giaovien (msgv, username, password, name, dob, sex, address, quequan, phone, email) values (19995870, 'aallmondh', 'WuoTNUsuXa', 'Amanda Allmond', '2002/03/28', false, '77145 Jay Lane', '9165 Dapin Hill', '880-285-5466', 'aallmondh@altervista.org');
insert into giaovien (msgv, username, password, name, dob, sex, address, quequan, phone, email) values (19995176, 'lribyi', '8DhTat3', 'Lonna Riby', '2002/02/10', true, '8 Ronald Regan Court', '587 Talisman Crossing', '649-637-8290', 'lribyi@jalbum.net');
insert into giaovien (msgv, username, password, name, dob, sex, address, quequan, phone, email) values (19992615, 'nattrillj', 'QYgrWCaT', 'Nikita Attrill', '2002/04/18', false, '5449 Sullivan Crossing', '86 Meadow Ridge Park', '456-601-5820', 'nattrillj@cloudflare.com');
insert into giaovien (msgv, username, password, name, dob, sex, address, quequan, phone, email) values (19995551, 'jhankink', 'BqQDSG45g', 'Jorge Hankin', '2002/02/27', false, '0286 Forster Pass', '32 Macpherson Parkway', '586-798-3401', 'jhankink@cyberchimps.com');
insert into giaovien (msgv, username, password, name, dob, sex, address, quequan, phone, email) values (19993063, 'mtolladyl', 'ibeeRZ', 'Merridie Tollady', '2002/03/11', false, '331 Farmco Place', '7 Fieldstone Court', '188-486-6009', 'mtolladyl@yahoo.co.jp');
insert into giaovien (msgv, username, password, name, dob, sex, address, quequan, phone, email) values (19993915, 'tmcturleym', '2yT0Bma0H', 'Tandy McTurley', '2002/03/23', true, '9 Boyd Road', '61927 Glendale Point', '867-451-8237', 'tmcturleym@mlb.com');



INSERT INTO monhoc(mamonhoc,tenmonhoc,sotinchi,thoiluong) VALUES ('IT3210','C Programming Language',2,27);
INSERT INTO monhoc(mamonhoc,tenmonhoc,sotinchi,thoiluong) VALUES ('ET3262','Tư duy công nghệ và thiết kế kỹ thuật',2,37);
INSERT INTO monhoc(mamonhoc,tenmonhoc,sotinchi,thoiluong) VALUES ('JP1120','Tiếng Nhật 2',0,47);
INSERT INTO monhoc(mamonhoc,tenmonhoc,sotinchi,thoiluong) VALUES ('IT4542','Quản trị phát triển phần mềm',2,34);
INSERT INTO monhoc(mamonhoc,tenmonhoc,sotinchi,thoiluong) VALUES ('IT3020','Toán rời rạc',3,34);
INSERT INTO monhoc(mamonhoc,tenmonhoc,sotinchi,thoiluong) VALUES ('MI1124','Giải tích II',3,34);
INSERT INTO monhoc(mamonhoc,tenmonhoc,sotinchi,thoiluong) VALUES ('IT4110','Tính toán khoa học',3,34);
INSERT INTO monhoc(mamonhoc,tenmonhoc,sotinchi,thoiluong) VALUES ('PE2601','Chạy',0,34);
INSERT INTO monhoc(mamonhoc,tenmonhoc,sotinchi,thoiluong) VALUES ('SSH1111','Triết học Mác - Lênin',2,34);
INSERT INTO monhoc(mamonhoc,tenmonhoc,sotinchi,thoiluong) VALUES ('IT3160','Nhập môn Trí tuệ nhân tạo',3,34);



INSERT INTO monday(mamonhoc,msgv) VALUES ('IT3210',19992708);
INSERT INTO monday(mamonhoc,msgv) VALUES ('IT4542',19992708);
INSERT INTO monday(mamonhoc,msgv) VALUES ('IT3020',19992708);
INSERT INTO monday(mamonhoc,msgv) VALUES ('ET3262',19992966);
INSERT INTO monday(mamonhoc,msgv) VALUES ('PE2601',19992966);
INSERT INTO monday(mamonhoc,msgv) VALUES ('IT3210',19994082);
INSERT INTO monday(mamonhoc,msgv) VALUES ('IT3020',19992054);
INSERT INTO monday(mamonhoc,msgv) VALUES ('MI1124',19993669);
INSERT INTO monday(mamonhoc,msgv) VALUES ('IT4110',19991720);
INSERT INTO monday(mamonhoc,msgv) VALUES ('PE2601',19991722);
INSERT INTO monday(mamonhoc,msgv) VALUES ('SSH1111',19991200);
INSERT INTO monday(mamonhoc,msgv) VALUES ('ET3262',19995155);
INSERT INTO monday(mamonhoc,msgv) VALUES ('JP1120',19993913);
INSERT INTO monday(mamonhoc,msgv) VALUES ('IT4542',19991777);
INSERT INTO monday(mamonhoc,msgv) VALUES ('IT3020',19994293);
INSERT INTO monday(mamonhoc,msgv) VALUES ('MI1124',19990613);
INSERT INTO monday(mamonhoc,msgv) VALUES ('IT4110',19994767);
INSERT INTO monday(mamonhoc,msgv) VALUES ('PE2601',19992701);
INSERT INTO monday(mamonhoc,msgv) VALUES ('SSH1111',19992848);
INSERT INTO monday(mamonhoc,msgv) VALUES ('IT3160',19994431);
INSERT INTO monday(mamonhoc,msgv) VALUES ('ET3262',19995870);
INSERT INTO monday(mamonhoc,msgv) VALUES ('JP1120',19995176);
INSERT INTO monday(mamonhoc,msgv) VALUES ('IT4542',19992615);
INSERT INTO monday(mamonhoc,msgv) VALUES ('IT3020',19995551);
INSERT INTO monday(mamonhoc,msgv) VALUES ('MI1124',19993063);
INSERT INTO monday(mamonhoc,msgv) VALUES ('IT4110',19993915);
INSERT INTO monday(mamonhoc,msgv) VALUES ('PE2601',19991777);
INSERT INTO monday(mamonhoc,msgv) VALUES ('SSH1111',19990613);
INSERT INTO monday(mamonhoc,msgv) VALUES ('IT3160',19995870);
INSERT INTO monday(mamonhoc,msgv) VALUES ('IT3210',19995155);


INSERT INTO lophoc values('D5-101');
INSERT INTO lophoc values('D5-102');
INSERT INTO lophoc values('D5-103');
INSERT INTO lophoc values('D5-104');
INSERT INTO lophoc values('D5-105');
INSERT INTO lophoc values('D5-106');
INSERT INTO lophoc values('D5-107');
INSERT INTO lophoc values('D9-101');
INSERT INTO lophoc values('D9-102');
INSERT INTO lophoc values('D9-103');
INSERT INTO lophoc values('D9-104');
INSERT INTO lophoc values('D9-105');
INSERT INTO lophoc values('D9-106');
INSERT INTO lophoc values('D9-107');
INSERT INTO lophoc values('D9-401');
INSERT INTO lophoc values('D9-402');
INSERT INTO lophoc values('D9-403');
INSERT INTO lophoc values('D9-404');
INSERT INTO lophoc values('D9-505');
INSERT INTO lophoc values('D9-506');
INSERT INTO lophoc values('D9-407');