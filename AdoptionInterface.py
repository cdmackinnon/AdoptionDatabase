# CSCI 421 Database Systems
# Group Members: Connor MacKinnon, Jake Richardson, Hannah Zimmerman

import psycopg2

conn = psycopg2.connect(dbname="databased")
cur = conn.cursor()

def GenerateAlienFile():
    alien = input("Enter the Alien's ID: ")
    query = """SELECT alien.name, age, vaccinated, orphanage_name, agency_name, planet
                    FROM alien LEFT JOIN medical ON alien.id = medical.alien_id LEFT JOIN agency ON alien.agency_name = agency.name
                    WHERE alien.id = %s"""
    cur.execute(query,(alien,))
    alien_info = cur.fetchone()
    if alien_info is None:
        print("Alien not found")
        return
    name, age, vaccinated, orphanage_name, agency_name, planet = alien_info
    print(f"Alien ID: {alien}")
    print(f"Name: {name}")
    print(f"Age: {age} years old1")
    print(f"Up-to-date on vaccines: {vaccinated}")
    print(f"Orphanage: {orphanage_name} on {planet}")
    print(f"Orphanage agency: {agency_name}")


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
    pass


def NewAdoptionRequest():
    pass


def DecideAdoptionRequest():
    pass


def GenerateOrphanageList():
    pass


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
        print("6. View all aliens at a specific orphanage")
        print("7. Exit")

        choice = input("Enter your choice (1-7): ")
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
            DecideAdoptionRequest()
        elif choice == '6':
            GenerateOrphanageList()
        elif choice == '7':
            print("Exiting program!")
            break
        else:
            print("Invalid choice. Please enter a number between 1 and 7.")
MainMenu()