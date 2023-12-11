# CSCI 421 Database Systems
# Group Members: Connor MacKinnon, Jake Richardson, Hannah Zimmerman

import psycopg2

conn = psycopg2.connect(dbname="databased")
cur = conn.cursor()

def GenerateAlienFile():
    alien = input("Enter the Alien's ID: ")
    query = """SELECT alien.name, age, vaccinated, orphanage_name, agency_name, planet, adopted.family_id
               AS adopted_family
               FROM alien
               LEFT JOIN medical ON alien.id = medical.alien_id
               LEFT JOIN agency ON alien.agency_name = agency.name
               LEFT JOIN adopted ON alien.id = adopted.alien_id
               WHERE alien.id = %s"""
    cur.execute(query, (alien,))
    alien_info = cur.fetchone()
    if alien_info is None:
        print("Alien not found")
        return
    name, age, vaccinated, orphanage_name, agency_name, planet, adopted_family = alien_info
    print(f"Alien ID: {alien}")
    print(f"Name: {name}")
    print(f"Age: {age} years old")
    print(f"Up-to-date on vaccines: {vaccinated}")
    print(f"Orphanage: {orphanage_name} on {planet}")
    print(f"Orphanage agency: {agency_name}")
    print(f"Adopted Family ID: {adopted_family if adopted_family else 'Not adopted'}")


def GenerateFamilyFile():
    family = input("Enter the Family's ID: ")
    query = """select family.ID, last_name, income, planet
                    from family left join inhabits on family.id = inhabits.family_id
                    where family.id = %s"""
    cur.execute(query,(family,))
    family_info = cur.fetchone()
    if family_info is None:
        print("Family not found")
        return
    id, last_name, income, planet = family_info
    print(f"Family ID: {family}")
    print(f"Last Name: {last_name}")
    print(f"Income: ${income}")
    print(f"Planet: {planet}")



def GenerateAdoptionRequests():
    query = """SELECT request_id, family_id, alien_id
               FROM adoption_request"""
    cur.execute(query)
    adoption_requests = cur.fetchall()

    if not adoption_requests:
        print("No adoption requests found.")
        return

    print("Open Adoption Requests:")
    for request_id, family_id, alien_id in adoption_requests:
        print(f"Request ID: {request_id}, Family ID: {family_id}, Alien ID: {alien_id}, Status: Open")
    print()


def NewAdoptionRequest():
    alien_id = input("Enter Alien ID: ")

    # Check if the alien is already adopted
    # Alien may exist in adopted without a family if the family changed their mind
    check_adopted_query = "SELECT * FROM adopted WHERE alien_id = %s"
    cur.execute(check_adopted_query, (alien_id,))
    alien_info = cur.fetchone()
    if alien_info:
        alien_id, family_id = alien_info
        if family_id is not None:
            print("This alien is already adopted.")
            return

    # Check if there is already an adoption request for this family and alien
    check_existing_request_query = "SELECT * FROM adoption_request WHERE alien_id = %s AND family_id = %s"
    cur.execute(check_existing_request_query, (alien_id, family_id))
    existing_request = cur.fetchone()
    if existing_request:
        print("There is already an adoption request for this family and alien.")
        return

    # After passing all check: prompt user for a non-null family ID
    while True:
        family_id = input("Enter Family ID: ")
        if family_id:
            break
        else:
            print("Family ID cannot be null. Please enter a valid Family ID.")

    # Create the request
    insert_request_query = "INSERT INTO adoption_request (family_id, alien_id) VALUES (%s, %s) RETURNING request_id"
    cur.execute(insert_request_query, (family_id, alien_id))
    request_id = cur.fetchone()[0]

    print(f"Adoption request created successfully. Request ID: {request_id}")



def DecideAdoptionRequest():
    request_id = input("Enter Request ID: ")

    # Check if the adoption request exists
    check_request_query = "SELECT alien_id, family_id FROM adoption_request WHERE request_id = %s"
    cur.execute(check_request_query, (request_id,))
    adoption_request = cur.fetchone()

    if adoption_request is None:
        print("Adoption request not found.")
        return

    alien_id, family_id = adoption_request

    print(f"Adoption Request ID: {request_id}")
    print(f"Alien ID: {alien_id}")
    print(f"Family ID: {family_id}")

    print("1. Accept Adoption Request")
    print("2. Deny Adoption Request")
    decision = input("Enter your decision (1 or 2): ")

    if decision == '1':
        # Insert into adopted table
        insert_adopted_query = "INSERT INTO adopted (alien_id, family_id) VALUES (%s, %s)"
        cur.execute(insert_adopted_query, (alien_id, family_id) if family_id else (alien_id,))
        print("Adoption request accepted. Alien added to the adopted table.")
    elif decision == '2':
        print("Adoption request denied.")
    else:
        print("Invalid decision. Please enter either 1 or 2.")

    # Delete the adoption request
    delete_query = "DELETE FROM adoption_request WHERE request_id = %s"
    cur.execute(delete_query, (request_id,))


def GenerateAdoptableList():
    query = """SELECT alien.id, alien.name, orphanages.name, agency, planet
                    FROM alien left JOIN orphanages ON alien.orphanage_name = orphanages.name AND alien.agency_name = orphanages.agency
                    JOIN agency ON orphanages.agency = agency.name
					WHERE alien.id NOT IN (
					SELECT alien_id
					FROM adopted )
                    GROUP BY alien.id, orphanages.name, agency, planet
                    ORDER BY alien.id;"""

    cur.execute(query)
    for i in cur:
        print("Alien ID: ", end="")
        print(i[0])

        print("Name: ", end="")
        print(i[1])

        print("Orphanage: ", end="")
        print(i[2])

        print("Orphanage Agency: ", end="")
        print(i[3])

        print("Planet: ", end="")
        print(i[4])

        print()


def OverviewAll():
    print("\nOverview of Aliens:")
    query_alien = """SELECT alien.id, alien.name, orphanages.name AS orphanage, agency.name AS agency, planet
                    FROM alien 
                    LEFT JOIN orphanages ON alien.orphanage_name = orphanages.name AND alien.agency_name = orphanages.agency
                    JOIN agency ON orphanages.agency = agency.name;"""
    cur.execute(query_alien)
    for alien_info in cur:
        print(f"Alien ID: {alien_info[0]}")
        print(f"Name: {alien_info[1]}")
        print(f"Orphanage: {alien_info[2] if alien_info[2] else 'Not specified'}")
        print(f"Orphanage Agency: {alien_info[3] if alien_info[3] else 'Not specified'}")
        print(f"Planet: {alien_info[4]}\n")

    print("\nOverview of Families:")
    query_family = """SELECT family.ID, last_name, income, planet
                    FROM family LEFT JOIN inhabits ON family.id = inhabits.family_id;"""
    cur.execute(query_family)
    for family_info in cur:
        print(f"Family ID: {family_info[0]}")
        print(f"Last Name: {family_info[1]}")
        print(f"Income: ${family_info[2]}")
        print(f"Planet: {family_info[3] if family_info[3] else 'Not specified'}\n")

    print("\nOverview of Planets:")
    query_planet = """SELECT name, galaxy, climate FROM planet;"""
    cur.execute(query_planet)
    for planet_info in cur:
        print(f"Planet Name: {planet_info[0]}")
        print(f"Galaxy: {planet_info[1]}")
        print(f"Climate: {planet_info[2]}\n")

# Interface for calling functions. Presents the user with all menu options and an option to exit
# Program should continue presenting the menu until the user chooses to exit
def MainMenu():
    while True:
        print("\nMain Menu:")
        print("1. View an alien’s file")
        print("2. View a family's file")
        print("3. View open adoption requests")
        print("4. Create new adoption request")
        print("5. Accept/Deny adoption request")
        print("6. View all adoptable aliens")
        print("7. See an overview of the database")
        print("8. Exit")

        choice = input("Enter your choice (1-8): ")
        print("\n")
        if choice == '1':
            GenerateAlienFile()
        elif choice == '2':
            GenerateFamilyFile()
        elif choice == '3':
            GenerateAdoptionRequests()
        elif choice == '4':
            NewAdoptionRequest()
        elif choice == '5':
            GenerateAdoptionRequests()
            DecideAdoptionRequest()
        elif choice == '6':
            GenerateAdoptableList()
        elif choice == '7':
            OverviewAll()
        elif choice == '8':
            print("Exiting program!")
            break
        else:
            print("Invalid choice. Please enter a number between 1 and 7.")
MainMenu()