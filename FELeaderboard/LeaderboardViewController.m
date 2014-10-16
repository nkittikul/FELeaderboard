//
//  LeaderboardViewController.m
//  FELeaderboard
//
//  Created by Narin Kittikul on 10/10/14.
//  Copyright (c) 2014 Narin Kittikul. All rights reserved.
//

#import "LeaderboardViewController.h"
#import "LeaderBoardCell.h"
#import <QuartzCore/QuartzCore.h>

@interface LeaderboardViewController ()
@property (nonatomic, strong) NSArray *leaders;
@property (nonatomic, strong) NSArray *playerPhotos;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITextField *titleField;

@end

@implementation LeaderboardViewController

- (id)init
{
    if (self) {
        float width = self.view.frame.size.width;
        float height = self.view.frame.size.height;
        self.view.backgroundColor = [UIColor colorWithRed:0 green:0.2 blue:0.2 alpha:1];
        
        self.titleField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, width, height*0.2)];
        self.titleField.text = @"Top Scores";
        self.titleField.textAlignment = NSTextAlignmentCenter;
        self.titleField.font = [UIFont fontWithName:@"Times New Roman" size: 40];
        self.titleField.textColor = [UIColor whiteColor];
        self.titleField.layer.shadowColor = [UIColor blackColor].CGColor;
        self.titleField.layer.shadowOpacity = 1.0;
        self.titleField.layer.shadowRadius = 1.0;
        self.titleField.layer.shadowOffset = CGSizeMake(0.0, 2.0);
        
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, height*0.2, width, height*0.8)];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.rowHeight = 100;
        self.tableView.backgroundColor = [UIColor colorWithRed:0 green:0.2 blue:0.2 alpha:1];
        
        [self.view addSubview:self.titleField];
        [self.view addSubview:self.tableView];
        
        NSURL *url = [[NSURL alloc] initWithString:@"https://keith.fanfareentertainment.com/api/v4/games/matching.json"];
        
        [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:url] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
            if (error){
                NSLog(@"Error retrieving data: %@", [error localizedDescription]);
            } else {
                [self getLeadersFromJSONData:data];
            }
        }];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)getLeadersFromJSONData:(NSData *)data
{
    NSError *error;
    NSDictionary *dict;
    dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    if (!dict){
        NSLog(@"Error converting JSON object: %@", [error localizedDescription]);
    } else {
        self.leaders = [dict valueForKey:@"leaders"];
        [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   return [self.leaders count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = [NSString stringWithFormat:@"%d",indexPath.row];
    LeaderBoardCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil){
        cell = [[LeaderBoardCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier player:[self.leaders objectAtIndex:indexPath.row]];
    }    
        return cell;
}

@end


