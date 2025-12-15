from faker import Faker
import csv
import os


fake = Faker('pl_PL')

current_folder = os.path.dirname(os.path.abspath(__file__))
file_path = os.path.join(current_folder, 'names.csv')


with open(file_path, 'w', newline='', encoding='utf-8-sig') as csvfile:
    fieldsnames = ['firstName', 'lastName']
    writer = csv.DictWriter(csvfile, fieldnames=fieldsnames)
    writer.writeheader()
    for i in range(100):
        first_name = fake.first_name() 
        last_name = fake.last_name()
        writer.writerow({'firstName': first_name , 'lastName': last_name})
