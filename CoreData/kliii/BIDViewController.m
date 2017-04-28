//
//  BIDViewController.m
//  kliii
//
//  Created by yzk on 14-7-24.
//  Copyright (c) 2014年 cooperLink. All rights reserved.
//

#import "BIDViewController.h"
#import "BIDFourLines.h"
#import "AppDelegate.h"

static NSString *const kLineEntityName = @"Line";
static NSString *const kLineNumberKey  = @"lineNumber";
static NSString *const kLineTextKey    = @"lineText";

static NSString *const kRootKey = @"kRootKey";

@interface BIDViewController ()

@end

@implementation BIDViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:kLineEntityName];
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request error:&error];
    if (objects == nil) {
        NSLog(@"There was an error");
    }
    for (NSManagedObject *oneObject in objects) {
        int lineNum = [[oneObject valueForKey:kLineNumberKey] intValue];
        NSString *lineText = [oneObject valueForKey:kLineTextKey];
        
        UITextField *tf = self.lineFields[lineNum];
        tf.text = lineText;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationWillResignActive:)
                                                 name:UIApplicationWillResignActiveNotification
                                               object:nil];
}

- (NSString *)dataFilePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
//    return [documentsDirectory stringByAppendingPathComponent:@"data.plist"];
    return [documentsDirectory stringByAppendingPathComponent:@"data.archive"];
}

- (void)applicationWillResignActive:(NSNotification *)nofi
{
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    NSError *error;
    for (int i=0; i<4; i++) {
        UITextField *tf = self.lineFields[i];
        
        NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:kLineEntityName];
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"(%K = %d)",kLineNumberKey,i];
        [request setPredicate:pred];
        
        NSArray *objects = [context executeFetchRequest:request error:&error];
        if (objects == nil) {
            NSLog(@"There was an error!");
        }
        
        NSManagedObject *theLine = nil;
        if ([objects count]>0) {
            theLine = [objects objectAtIndex:0];
        }else {
            NSLog(@"a--a---fds--fadsf");
            theLine = [NSEntityDescription insertNewObjectForEntityForName:kLineEntityName
                                                    inManagedObjectContext:context];
        }
        [theLine setValue:[NSNumber numberWithInt:i] forKeyPath:kLineNumberKey];
        [theLine setValue:tf.text forKeyPath:kLineTextKey];
            
    }
    
    [appDelegate saveContext];
}
@end
