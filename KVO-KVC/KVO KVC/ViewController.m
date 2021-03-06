//
//  ViewController.m
//  KVO KVC Demo
//
//  Created by Paul Solt on 4/9/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

#import "ViewController.h"
#import "LSIDepartment.h"
#import "LSIEmployee.h"
#import "LSIHRController.h"


@interface ViewController ()

@property (nonatomic) LSIHRController *hrController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    LSIDepartment *marketing = [[LSIDepartment alloc] init];
    marketing.name = @"Marketing";
    LSIEmployee * philSchiller = [[LSIEmployee alloc] init];
    philSchiller.name = @"Phil";
    philSchiller.jobTitle = @"VP of Marketing";
    philSchiller.salary = 10000000; 
    marketing.manager = philSchiller;

    
    LSIDepartment *engineering = [[LSIDepartment alloc] init];
    engineering.name = @"Engineering";
    LSIEmployee *craig = [[LSIEmployee alloc] init];
    craig.name = @"Craig";
    craig.salary = 9000000;
    craig.jobTitle = @"Head of Software";
    engineering.manager = craig;
    
    LSIEmployee *e1 = [[LSIEmployee alloc] init];
    e1.name = @"Chad";
    e1.jobTitle = @"Engineer";
    e1.salary = 200000;
    
    LSIEmployee *e2 = [[LSIEmployee alloc] init];
    e2.name = @"Lance";
    e2.jobTitle = @"Engineer";
    e2.salary = 250000;
    
    LSIEmployee *e3 = [[LSIEmployee alloc] init];
    e3.name = @"Joe";
    e3.jobTitle = @"Marketing Designer";
    e3.salary = 100000;
    
    [engineering addEmployee:e1];
    [engineering addEmployee:e2];
    [marketing addEmployee:e3];

    LSIHRController *controller = [[LSIHRController alloc] init];
    [controller addDepartment:engineering];
    [controller addDepartment:marketing];
    self.hrController = controller;
    
//    NSLog(@"%@", self.hrController);
    
    // Key Value Coding: KVC
    // * Core Data
    // * Cocoa Bindings (UI + Model = SwiftUI)
    // @property NSString *name;  // Properties are automatically KVC
    // 1. Accessor for a property
        // - (NSString *)name;
    // 2. Setter for a property
        // - (void)setName:(NSString *)name
    // 3. Instance variable to set
    // Modify our Data using the self.name syntax (not _name)
    // 1. init/dealloc always use: _name =
    // 2. Normal methods always use: self.name =
    
    NSString *name = [craig name];
    NSLog(@"Name: %@", name);
    
    //    NSString *name2 = [craig valueForKey:@"name"];
    //    NSString *name2 = [craig valueForKey:@"firstName"]; // No build issues, CRASHES at runtime!
    NSString *name2 = [craig valueForKey:@"privateName"]; // No build issues, accesses a private property
    NSLog(@"Name2: %@", name2);
    
    [craig setValue:@"Bob" forKey:@"name"];
    NSLog(@"Name Change: %@", craig.name);
    
    // Collections and Keypaths
    //    NSLog(@"Departments1: %@", [[self hrController] departments]); // method calling
    //    NSLog(@"Departments2: %@", self.hrController.departments); // dot syntax
    
    // keypath: departments
    NSLog(@"Departments3: %@", [self.hrController valueForKey/*path*/:@"departments"]); // kvc syntax
    
    NSLog(@"Department Name: %@", [self.hrController valueForKeyPath:@"departments.@distinctUnionOfArrays.employees"]);
    
    NSArray<LSIEmployee *> *allEmployees = [self.hrController valueForKeyPath:@"departments.@distinctUnionOfArrays.employees"];
    NSLog(@"Department Employees: %@", allEmployees);
    
    NSLog(@"Salaries: %@", [allEmployees valueForKey/*Path*/:@"salary"]);
    NSLog(@"Salaries: %@", [allEmployees valueForKeyPath:@"@max.salary"]);
    NSLog(@"Salaries: %@", [allEmployees valueForKeyPath:@"@avg.salary"]);
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
//    NSLog(@"Departments: %@", [self.hrController departments]);
//    NSLog(@"Departments: %@", [self.hrController valueForKeyPath:@"departments"]);
//    
//    NSLog(@"Departments employees: %@", [self.hrController valueForKeyPath:@"departments.employees"]);
//    
//    NSLog(@"Departments employees: %@", [self.hrController valueForKeyPath:@"departments.@distinctUnionOfArrays.employees"]);
//    
//    NSArray *allEmployees = [self.hrController valueForKeyPath:@"departments.@distinctUnionOfArrays.employees"];
//    
//    NSLog(@"Salaries: %@", [allEmployees valueForKeyPath:@"salary"]);
//    NSLog(@"Highest Salary: %@", [allEmployees valueForKeyPath:@"@max.salary"]); //@max @min @avg
//    NSLog(@"Average Salary: %@", [allEmployees valueForKeyPath:@"@avg.salary"]);
}


@end
