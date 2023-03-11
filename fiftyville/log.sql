-- Keep a log of any SQL queries you execute as you solve the mystery.


--crime scene descriptions
SELECT description
FROM crime_scene_reports
WHERE month = 7 AND day = 28
AND street = 'Humphrey Street';

--result:
--theft took place at 10:15am
--location: Humphrey Street bakery

SELECT name, transcript
FROM interviews
WHERE year = 2021 AND month = 7 AND day = 28;

--10 mins after look for cars left the parking lot
--ATM on Leggett Street in the morning, withdraw
--7/29 earliest flight
--witness names: Ruth, Eugene, Raymond

--find license plates that leaves between 10:15-10:25
SELECT hour, minute,license_plate, activity
FROM bakery_security_logs
WHERE year = 2021 AND month = 7 AND day = 28 AND hour = 10 AND minute >=15 and minute <=25;

--the above query returns 8 license plates
--let's find out their names next
SELECT name, phone_number, passport_number
FROM people
WHERE license_plate in
(
    SELECT license_plate
    FROM bakery_security_logs
    WHERE year = 2021 AND month = 7 AND day = 28 AND hour = 10 AND minute >=15 and minute <=25
);

--suspect names: Vanessa, Barry, Iman, Sofia, Luca, Diana, Kelsey, Bruce

--check ATM activity: withdraw, Leggett Street, morning
SELECT people.name
FROM people
JOIN bank_accounts, atm_transactions ON atm_transactions.account_number = bank_accounts.account_number AND bank_accounts.person_id = people.id

WHERE year = 2021 AND month = 7 AND day = 28 AND transaction_type = 'withdraw';
--this returns a list of names (very long)

--find out which suspects' names are in the above list
SELECT name FROM people
WHERE license_plate in
(
    SELECT license_plate
    FROM bakery_security_logs
    WHERE year = 2021 AND month = 7 AND day = 28 AND hour = 10 AND minute >=15 and minute <=25
)
AND name in
(
    SELECT people.name
FROM people
JOIN bank_accounts, atm_transactions ON atm_transactions.account_number = bank_accounts.account_number AND bank_accounts.person_id = people.id

WHERE year = 2021 AND month = 7 AND day = 28 AND transaction_type = 'withdraw' AND atm_location = 'Leggett Street'
);
--this gives us a list of 4 sus: Iman, Luca, Diana, Bruce

--get the passport number of the above 4 sus
SELECT passport_number FROM people
WHERE license_plate in
(
    SELECT license_plate
    FROM bakery_security_logs
    WHERE year = 2021 AND month = 7 AND day = 28 AND hour = 10 AND minute >=15 and minute <=25
)
AND name in
(
    SELECT people.name
FROM people
JOIN bank_accounts, atm_transactions ON atm_transactions.account_number = bank_accounts.account_number AND bank_accounts.person_id = people.id

WHERE year = 2021 AND month = 7 AND day = 28 AND transaction_type = 'withdraw' AND atm_location = 'Leggett Street'
);

--get a list of 10 flights out of fiftyville on 7/29/2021
SELECT id, hour, minute FROM flights
WHERE year = 2021 AND month = 7 AND day =29 AND origin_airport_id =
(
    SELECT id FROM airports
    WHERE city = 'Fiftyville'
)
ORDER BY hour;

--result: earliest flight id is 36

--find out which sus were on that flight
SELECT name FROM people
WHERE license_plate in
(
    SELECT license_plate
    FROM bakery_security_logs
    WHERE year = 2021 AND month = 7 AND day = 28 AND hour = 10 AND minute >=15 and minute <=25
)
AND name in
(
    SELECT people.name
    FROM people
    JOIN bank_accounts, atm_transactions ON atm_transactions.account_number = bank_accounts.account_number AND bank_accounts.person_id = people.id
    WHERE year = 2021 AND month = 7 AND day = 28 AND transaction_type = 'withdraw' AND atm_location = 'Leggett Street'
)
AND name in
(
    SELECT people.name
    FROM people
    JOIN passengers on passengers.passport_number = people.passport_number
    WHERE flight_id = 36
);

--this returns Luca and Bruce

--find out the callers in that time frame
SELECT name FROM people
WHERE license_plate in
(
    SELECT license_plate
    FROM bakery_security_logs
    WHERE year = 2021 AND month = 7 AND day = 28 AND hour = 10 AND minute >=15 and minute <=25
)
AND name in
(
    SELECT people.name
    FROM people
    JOIN bank_accounts, atm_transactions ON atm_transactions.account_number = bank_accounts.account_number AND bank_accounts.person_id = people.id
    WHERE year = 2021 AND month = 7 AND day = 28 AND transaction_type = 'withdraw' AND atm_location = 'Leggett Street'
)
AND name in
(
    SELECT people.name
    FROM people
    JOIN passengers on passengers.passport_number = people.passport_number
    WHERE flight_id = 36
)
AND NAME in
(
    SELECT name FROM people
    WHERE phone_number in
    (
        SELECT caller FROM phone_calls
        WHERE year = 2021 AND month = 7 AND day = 28 AND duration < 60
    )
);

--and we have found him: Bruce

--find out who did Bruce call
SELECT name from people
WHERE phone_number = '(375) 555-8161';
--we got Robin

--find out flight destination
SELECT city FROM airports
WHERE id =
(
    SELECT destination_airport_id
    FROM flights
    WHERE id = 36
);


--result: New York City