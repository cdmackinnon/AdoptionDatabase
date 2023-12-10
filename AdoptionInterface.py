# CSCI 421 Database Systems
# Group Members: Connor MacKinnon, Jake Richardson, Hannah Zimmerman

import psycopg2

conn = psycopg2.connect(dbname="databased")
cur = conn.cursor()



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