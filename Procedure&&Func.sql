--Futbol liqasında mübarizə aparan komandaların vəziyyətlərinin, oynadıqları oyunların nəticələrinin və futbolçuların qollarının sayının izlənməsini təmin edəcək bir proqram təminatının hazırlanması istənilir. Bu məqsədlə futbol komandalarının vəziyyətləri ilə əlaqədar məlumatlar "komandalar" adlı bir cədvəldə saxlanılır.
--sütunadı -Məlumat növü
--Komanda kodu -1-99 arası tam ədəd
--Komanda adı-50 simvol
--Qaliblik sayı - Tam ədəd
--Bərabərlik sayı-Tam ədəd
--Məğlubiyyət say-Tam ədəd
--Atdığı qol sayı-Tam ədəd
--Yediyi qol say-Tam ədəd

create table Teams(
TeamCode int Primary key check(TeamCode between 1 and 99),
TeamName nvarchar(50),
NumberOfWins int default 0,
NumberOfDraws int default 0,
NumberOfDefeats int default 0,
GoalsScored int default 0,
GoalsConceded int default 0
)


INSERT INTO Teams (TeamCode, TeamName, NumberOfWins, NumberOfDraws, NumberOfDefeats, GoalsScored, GoalsConceded)
VALUES
(1, 'Karabakh', 12, 4, 3, 45, 22),
(2, 'Neftchi', 10, 6, 3, 40, 25),
(3, 'Qarabag', 8, 7, 4, 35, 30),
(4, 'Zira', 9, 5, 7, 30, 28);

--Bu liqada mübarizə edən komandaların futbolçuları və attıqları qollar haqqında məlumatlar, aşağıda verilmiş "futbolçular " cədvəlində saxlanılır.
--Sütun adı-Məlumat növü
--Forma nömrəsi - 1-99 arası tam ədəd
--Ad Soyad - 50 simvol
--Atdığı qol sayı -Tam ədəd

create table Players(
FormCode int Primary key check (FormCode between 1 and 99),
[Name] nvarchar(50),
Surname nvarchar(50),
GoalsScored int default 0,
TeamCode int  foreign key references Teams(TeamCode)
)

INSERT INTO Players (FormCode, [Name], Surname, GoalsScored, TeamCode)
VALUES
(10, 'Cica', 'Redon', 10, 1),
(11, 'Zubir', 'Abdullah', 12, 1),
(20, 'Vusal', 'Huseynov', 8, 2),
(21, 'Elchin', 'Ismayilov', 9, 2),
(30, 'Rauf', 'Aliyev', 7, 3),
(31, 'Nijat', 'Mammadov', 5, 3),
(40, 'Aynur', 'Guliyeva', 6, 4),
(41, 'Leyla', 'Huseynova', 4, 4);
--Həmçinin, liqanın müddətində hər həftə edilən oyunların nəticələri, aşağıda verilmiş "oyunlar" cədvəlində saxlanılır.
--Sütun adı - Məlumat növü
--Həftə nömrəsi-Tam ədəd
--Ev sahibi komandanın kodu - Tam ədəd
--Qonaq komandanın kodu - Tam ədəd
--Ev sahibi komandanın qol sayı- Tam ədəd
--Qonaq komandanın qol sayı - Tam ədəd

create table Games(
WeekNumber int,
HomeTeamCode int,
GuestTeamCode int,
HomeTeamGoals int,
GuestTeamGoals int,
Primary key(WeekNumber,HomeTeamCode,GuestTeamCode),
foreign key(HomeTeamCode) references Teams(TeamCode),
foreign key(GuestTeamCode) references Teams(TeamCode)

)

INSERT INTO Games (WeekNumber, HomeTeamCode, GuestTeamCode, HomeTeamGoals, GuestTeamGoals)
VALUES
(1, 1, 2, 3, 1),
(1, 3, 4, 2, 2),
(2, 1, 3, 1, 0),
(2, 2, 4, 2, 1),
(3, 1, 4, 4, 1),
(3, 2, 3, 3, 2);
--1.     Bitmiş oyuna dair nəticələrin daxil edilməsi (Procedure yazilacaq)
--Əvvəlcə istifadəçidən həftə nömrəsi alınmalıdır(yeni procedure parametr kimi verilecek). Sonra bitmiş bir oyuna dair əvvəlcə ev sahibi komanda sonra da qonaq komanda üçün; komanda kodu, qol sayısı, bu oyunda qol atan hər futbolçu üçün formanın nömrəsi və atdığı qol sayıları məlumatları istifadəçidən alınmalıdır. Daha sonra isə, bitmiş oyuna dair məlumatı "oyunlar" cədvəlinə olunmalı və komandaların və futbolçuların atdığı qol sayıları ilə əlaqəli cədvəllər yenilənməlidir. 
create table HomeTeamPlayers(
FormCode int,
GoalsScored int
)
create table GuestTeamPlayers(
FormCode int,
GoalsScored int
)

--create procedure EnterResult(
--@WeekNumber int,
--@HomeTeamCode int,
--@GuestTeamCode int,
--@HomeTeamsGoals int,
--@GuestTeamGoals int
--)
--as 
--begin
--Insert into Games(WeekNumber,HomeTeamCode,GuestTeamCode,HomeTeamGoals,GuestTeamGoals)
--Values(@WeekNumber,@HomeTeamCode,@GuestTeamCode,@HomeTeamsGoals,@GuestTeamGoals)


----komandalar cedveli procedure esasen update olunur, 1ci hometeam ucun
--Update Teams
--set GoalsScored = GoalsScored + @HomeTeamsGoals,
--GoalsConceded = GoalsConceded + @GuestTeamGoals,
--NumberOfWins = NumberOfWins + Case when @HomeTeamsGoals > @GuestTeamGoals then 1 else 0 end,
--NumberOfDefeats = NumberOfDefeats + Case when @HomeTeamsGoals < @GuestTeamGoals  then 1 else 0 end,
--NumberOfDraws = NumberOfDraws + Case when @HomeTeamsGoals = @GuestTeamGoals then 1 else 0 end
--where TeamCode = @HomeTeamCode

----2ci guestteam ucun
--Update Teams
--set GoalsScored = GoalsScored + @GuestTeamGoals,
--GoalsConceded = GoalsConceded + @HomeTeamsGoals,
--NumberOfWins = NumberOfWins + Case when @GuestTeamGoals > @HomeTeamsGoals then 1 else 0 end,
--NumberOfDefeats = NumberOfDefeats + Case when @GuestTeamGoals < @HomeTeamsGoals then 1 else 0 end,
--NumberOfDraws = NumberOfDraws + case when @GuestTeamGoals = @HomeTeamsGoals then 1 else 0 end
--where TeamCode = @GuestTeamCode


----Oyuncu cedvellerinin update olunmasi, 1ci hometeam ucun
--update Players
--set GoalsScored = GoalsScored + p .GoalsScored 
--from Players p
--join HomeTeamPlayers h 
--on p.FormCode = h.FormCode
--where p.TeamCode = @HomeTeamCode

----GuestTeam ucun

--update Players
--set GoalsScored = GoalsScored + p.GoalsScored
--from Players p
--join GuestTeamPlayers g
--on p.FormCode = g.FormCode
--where p.TeamCode = @GuestTeamCode



--end

create procedure EnterResults
    @weeknumber int,
    @hometeamcode int,
    @guestteamcode int,
    @hometeamgoals int,
    @guestteamgoals int
as
begin
    -- insert the game result into the games table
    insert into games (weeknumber, hometeamcode, guestteamcode, hometeamgoals, guestteamgoals)
    values (@weeknumber, @hometeamcode, @guestteamcode, @hometeamgoals, @guestteamgoals);

    -- update the home team's statistics
    update teams
    set GoalsScored =GoalsScored + @hometeamgoals,
        goalsconceded = goalsconceded + @guestteamgoals,
        numberofwins = numberofwins + case when @hometeamgoals > @guestteamgoals then 1 else 0 end,
        numberofdefeats = numberofdefeats + case when @hometeamgoals < @guestteamgoals then 1 else 0 end,
        numberofdraws = numberofdraws + case when @hometeamgoals = @guestteamgoals then 1 else 0 end
    where teamcode = @hometeamcode;

    -- update the guest team's statistics
    update teams
    set GoalsScored = GoalsScored + @guestteamgoals,
        goalsconceded = goalsconceded + @hometeamgoals,
        numberofwins = numberofwins + case when @guestteamgoals > @hometeamgoals then 1 else 0 end,
        numberofdefeats = numberofdefeats + case when @guestteamgoals < @hometeamgoals then 1 else 0 end,
        numberofdraws = numberofdraws + case when @guestteamgoals = @hometeamgoals then 1 else 0 end
    where teamcode = @guestteamcode;

    -- update home team players' goals
    update players
    set goalsscored = GoalsScored + h.goalsscored
    from players p
    join hometeamplayers h on p.formcode = h.formcode
    where p.teamcode = @hometeamcode;

    -- update guest team players' goals
    update players
    set GoalsScored = GoalsScored + g.goalsscored
    from players p
    join guestteamplayers g on p.formcode = g.formcode
    where p.teamcode = @guestteamcode;
end;



insert into teams (teamcode, teamname)
values (10, 'Home Team'), (20, 'Guest Team');


insert into HomeTeamPlayers (FormCode, GoalsScored)
values (19, 2), (10, 1);

insert into GuestTeamPlayers (FormCode, GoalsScored)
values (7, 1), (90, 2);

exec EnterResults
    @weeknumber = 1,
    @hometeamcode = 10,
    @guestteamcode = 20,
    @hometeamgoals = 3,
    @guestteamgoals = 3;

	select * from Teams

	select * from HomeTeamPlayers
	select * from GuestTeamPlayers


--2.     Bir komandanın cari vəziyyətinin və futbolçularının siyahılanması (Procedure yazilacaq)
--İstifadəçidən görmək istədiyi komandanın adı alınaraq(yeni procedure parametr kimi verilecek), cari durumu ilə əlaqədar məlumatlar və futbolçularına dair məlumatlar formanın nömrələrinə görə kiçikdən böyüyə doğru sıralanmış şəkildə aşağıdakı kimi siyahılanmalıdır:
--Komanda              O  G  H  M  AQ  YQ  AVR X
----------------------   -- -- -- -- --  --  --- ----
--Qarabağ                32 23 4  5  85  32  53  73
--Futbolçu Məlumatları:  
--Forma No       Ad Soyad           AA
--------------        ----------------      --
--19                   Cica Redon        10
--10                    Zubir Abdullah  12

create or alter procedure ListSituationAndPlayers(@TeamName nchar(50))
as 
begin
 select TeamName,
NumberOfDefeats,               
NumberOfDraws ,                 
NumberOfWins ,                  
GoalsConceded ,            
GoalsScored ,                  
(GoalsScored - GoalsConceded) AS [Differences]  
from Teams
Where TeamName = @TeamName;

select FormCode,
[Name],
Surname,
GoalsScored
from Players
where TeamCode = (Select TeamCode From Teams Where TeamName = @TeamName)
order by FormCode
end


exec ListSituationAndPlayers @TeamName = 'Neftchi'

--3.     Puan cədvəlinin sıralanması (View yazilacaq)
--Bütün komandalar, nəticələrinə görə böyük sıradan kiçiyə doğru (puanları eyni olanlar averajlarına görə böyük sıradan kiçiyə doğru) aşağıdakı şəkildə sıralanmalıdır:
--Komanda                                G         Q         H         M        AQ      YQ      AVR    X

----------------------                     --         --         --         --        --         --          ---       ----
--Qarabağ                                  32        23        4          5          85        32        53        73
--Sumqayıt                                32        13        11        8          53        34        19        50
--Neftçi                                     32        14        8          10        43        33        10        50

Go
create view ListRankScore
as
select TeamName,
NumberOfWins,
NumberOfDraws,
NumberOfDefeats,
GoalsScored,
GoalsConceded,
(GoalsScored*1 / NULLIF((NumberOfWins + NumberOfDraws + NumberOfDefeats), 0)) as [Average],
(NumberOfWins+NumberOfDefeats) as [Results]
from Teams 


select * from ListRankScore
order by
Average desc,
Results desc


--4.     Ən çox qol atan və ən çox qol yiyən komandaların sıralanması (View yazilacaq)
--Ən çox qol atan ilk komandanı və ən çox qol yiyən son komandalar tapılıb aşağıdakı şəkildə sıralanmalıdır:
--Komanda                    AQ      YQ     
----------------------         --         ---  
--Qarabağ                      85        32
--Qəbələ                        23        61

Go
create or alter view RankTeamsByGoals
as
select TeamName,
GoalsScored,
GoalsConceded
from Teams

select * from RankTeamsByGoals
order by
GoalsScored desc,
GoalsConceded asc


--5.     Liqdə ən çox qol atan futbolçunun sıralanması (View yazilacaq)
--Liqdə ən çox qol atan futbolçu tapılıb aşağıdakı şəkildə sıralanmalıdır:
--Komanda Adı             Forma No                  Ad Soyad                                AA
----------------------        ------------                  --------------------
--Qarabağ                      18                               Olavio Juninyo                       17
--Səbail                         9                                 Aleksandr Ramalinqom         13
--Qarabağ                      7                                 Yassin Benzia                        12
--Qarabağ                      90                               Nəriman Axundzadə              10

Go
create view RankPlayersByGoals
as
select p.Name,p.Surname,p.FormCode,p.GoalsScored,t.TeamName
from Players p
join Teams t
on p.TeamCode = t.TeamCode

select * from RankPlayersByGoals
order by GoalsScored 