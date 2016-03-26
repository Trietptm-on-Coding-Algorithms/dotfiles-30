#!/bin/python
import npyscreen

class myEmployeeForm(npyscreen.Form):
    def create(self):
        self.myName = self.add(npyscreen.TitleText, name='Name: ')
        self.myDepartment = self.add(npyscreen.TitleSelectOne, scroll_exit=True, max_height=3, \
        name='Department', values= ['Dep1','Dep2'])

def myFunction(*args):
    F = myEmployeeForm(name = "New employee")
    F.edit()
    return "Created record for " + F.myName.value

if __name__ == '__main__':
    print npyscreen.wrapper_basic(myFunction)
