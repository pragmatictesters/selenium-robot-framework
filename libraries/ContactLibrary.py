

import random


class Contact:
    def __init__(self, first_name, last_name, birthdate, email, street1, street2, city, postal_code, phone, state, country):
        self.first_name = first_name
        self.last_name = last_name
        self.birthdate = birthdate
        self.email = email
        self.street1 = street1
        self.street2 = street2
        self.city = city
        self.postal_code = postal_code
        self.phone = phone
        self.state = state
        self.country = country

    def to_dict(self):
        return f"'firstName': '{self.first_name}', \
            'lastName': '{self.last_name}', \
            'birthdate': '{self.birthdate}', \
            'email': '{self.email}', \
            'phone': '{self.phone}', \
            'street1': '{self.street1}', \
            'street2': '{self.street2}', \
            'city': '{self.city}', \
            'stateProvince': '{self.state}', \
            'postalCode': '{self.postal_code}', \
            'country': '{self.country}'"
    
class ContactLibrary:
    def generate_random_contact(self):
        suffix = random.randint(1000, 9999)
        first = f"Janesh{suffix}"
        last = f"Kodikara{suffix}"
        email = f"{first.lower()}.{last.lower()}@test.com"
        contact = Contact(first, last, "09/09/1974", email, "street1", "street2", "city", "11870", "0718732024", "Western", "Sri Lanka")
        return contact.to_dict()