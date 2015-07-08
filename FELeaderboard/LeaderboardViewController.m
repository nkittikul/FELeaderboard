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
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation LeaderboardViewController

- (id)init
{
    if (self = [super init]) {
        _leaders = [NSArray array];
    }
    return self;
}

- (void)viewDidLoad
{
    NSURL *url = [[NSURL alloc] initWithString:@"https://keith.fanfareentertainment.com/api/v4/games/matching.json"];
    
    [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:url] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if (error){
            NSLog(@"Error retrieving data: %@", [error localizedDescription]);
        } else {
            [self getLeadersFromJSONData:data];
        }
    }];
    
    self.view.backgroundColor = [UIColor colorWithRed:0 green:0.2 blue:0.2 alpha:1];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.text = @"Top Scores";
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont fontWithName:@"Arial" size: 40];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.layer.shadowColor = [UIColor blackColor].CGColor;
    self.titleLabel.layer.shadowOpacity = 1.0;
    self.titleLabel.layer.shadowRadius = 1.0;
    self.titleLabel.layer.shadowOffset = CGSizeMake(0.0, 2.0);
    [self.titleLabel setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 100;
    self.tableView.backgroundColor = [UIColor colorWithRed:0 green:0.2 blue:0.2 alpha:1];
    [self.tableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.tableView];
    
}

-(void)viewWillLayoutSubviews
{
    float width = self.view.bounds.size.width;
    float height = self.view.bounds.size.height;
    self.titleLabel.frame = CGRectMake(0, 0, width, height*0.2);
    self.tableView.frame = CGRectMake(0, height*0.2, width, height*0.8);

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
    LeaderBoardCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LeaderboardCell"];
    NSDictionary *playerInfo = [self.leaders objectAtIndex:indexPath.row];
    
    if (cell == nil){
        cell = [[LeaderBoardCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LeaderboardCell"];
    }

    NSString *imageURL = [playerInfo objectForKey:@"image_url"];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:imageURL]];
    [cell getPlayerImageFromRequest:request];
    
    NSString *name = [playerInfo objectForKey:@"name"];
    cell.nameLabel.text = name;
    
    
    NSNumber *score = [playerInfo objectForKey:@"score"];
    cell.scoreLabel.text = [NSString stringWithFormat:@"Score: %@", [score stringValue]];

    NSNumber *rank = [playerInfo objectForKey:@"rank"];
    cell.rankLabel.text = [rank stringValue];
    
    [cell addSubview:cell.playerImageView];
    [cell addSubview:cell.nameLabel];
    [cell addSubview:cell.scoreLabel];
    [cell addSubview:cell.rankLabel];
    
    return cell;
}

@end


