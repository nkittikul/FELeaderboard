//
//  LeaderBoardCell.m
//  FELeaderboard
//
//  Created by Narin Kittikul on 10/14/14.
//  Copyright (c) 2014 Narin Kittikul. All rights reserved.
//

#import "LeaderBoardCell.h"
#import <QuartzCore/QuartzCore.h>


@interface LeaderBoardCell ()
@property (nonatomic, strong) NSMutableData *data;
@end

@implementation LeaderBoardCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setFrame:CGRectMake(0, 0, self.frame.size.width, 100)];
        self.layer.cornerRadius = 8;
        self.layer.masksToBounds = YES;
        self.data = [[NSMutableData alloc] init];
        int colorHelper = [reuseIdentifier intValue] % 1;
        self.backgroundColor = [UIColor colorWithRed:0 green:0.1*colorHelper+0.25 blue:0.1*colorHelper+0.25 alpha:1];
        self.userInteractionEnabled = NO;
        float cellHeight = self.frame.size.height;
        float cellWidth = self.frame.size.width;
        [self setSeparatorInset:UIEdgeInsetsZero];
        
        self.playerImageView = [[UIImageView alloc] initWithImage:nil];
        [self.playerImageView setFrame:CGRectMake(cellWidth*0.15, cellHeight*0.1, cellWidth*0.2, cellHeight*0.8)];
        
        self.nameLabel = [[UILabel alloc] init];
        [self.nameLabel setFont:[UIFont fontWithName:@"Arial" size:cellHeight*0.2]];
        [self.nameLabel setFrame:CGRectMake(cellWidth*0.35, 0, cellWidth*0.65, cellHeight*0.5)];
        self.nameLabel.textColor = [UIColor whiteColor];
        self.nameLabel.textAlignment = NSTextAlignmentCenter;
        self.nameLabel.adjustsFontSizeToFitWidth = YES;
        
        self.scoreLabel = [[UILabel alloc] init];
        [self.scoreLabel setFont:[UIFont fontWithName:@"Arial" size:cellHeight*0.2]];
        [self.scoreLabel setFrame:CGRectMake(cellWidth*0.35, cellHeight*0.5, cellWidth*0.65, cellHeight*0.5)];
        self.scoreLabel.textColor = [UIColor whiteColor];
        self.scoreLabel.textAlignment = NSTextAlignmentCenter;
        self.scoreLabel.adjustsFontSizeToFitWidth = YES;

        self.rankLabel = [[UILabel alloc] init];
        [self.rankLabel setFrame:CGRectMake(0, 0, cellWidth*0.15, cellHeight)];
        [self.rankLabel setFont:[UIFont fontWithName:@"Arial" size:cellHeight*0.7]];
        self.rankLabel.layer.shadowOpacity = 1.0;
        self.rankLabel.layer.shadowRadius = 1.0;
        self.rankLabel.layer.shadowColor = [UIColor blackColor].CGColor;
        self.rankLabel.layer.shadowOffset = CGSizeMake(0.0, 2.0);
        self.rankLabel.textColor = [UIColor whiteColor];
        self.rankLabel.textAlignment = NSTextAlignmentCenter;
        self.rankLabel.adjustsFontSizeToFitWidth = YES;

        
    }
    return self;
}

- (void)getPlayerImageFromRequest:(NSURLRequest *)request
{
    NSURLConnection *connection = [[NSURLConnection alloc]
                                   initWithRequest:request
                                   delegate:self
                                   startImmediately:NO];
    [connection scheduleInRunLoop:[NSRunLoop currentRunLoop]
                          forMode:NSRunLoopCommonModes];
    [connection start];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.data appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    UIImage *playerImage = [UIImage imageWithData:self.data];
    [self.playerImageView setImage:playerImage];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

}

@end
