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
@property (nonatomic, strong) UIImageView *playerImageView;
@property (nonatomic, retain) NSMutableData *data;
@end

@implementation LeaderBoardCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier player:(NSDictionary *)playerInfo
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setFrame:CGRectMake(0, 0, self.frame.size.width, 100)];
        self.layer.cornerRadius = 8;
        self.layer.masksToBounds = YES;
        self.data = [[NSMutableData alloc] init];
        int colorHelper = [reuseIdentifier intValue] % 5;
        self.backgroundColor = [UIColor colorWithRed:0 green:0.1*colorHelper+0.25 blue:0.1*colorHelper+0.25 alpha:1];
        self.userInteractionEnabled = NO;
        float cellHeight = self.frame.size.height;
        float cellWidth = self.frame.size.width;
        [self setSeparatorInset:UIEdgeInsetsZero];
        
        NSString *imageURL = [playerInfo objectForKey:@"image_url"];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:imageURL]];
        NSURLConnection *connection = [[NSURLConnection alloc]
                                       initWithRequest:request
                                       delegate:self
                                       startImmediately:NO];
        [connection scheduleInRunLoop:[NSRunLoop currentRunLoop]
                              forMode:NSRunLoopCommonModes];
        [connection start];
        self.playerImageView = [[UIImageView alloc] initWithImage:nil];
        [self.playerImageView setFrame:CGRectMake(cellWidth*0.15, cellHeight*0.1, cellWidth*0.2, cellHeight*0.8)];
        
        NSString *name = [playerInfo objectForKey:@"name"];
        UILabel *nameLabel = [[UILabel alloc] init];
        [nameLabel setFont:[UIFont fontWithName:@"Times New Roman" size:cellHeight*0.2]];
        [nameLabel setFrame:CGRectMake(cellWidth*0.35, 0, cellWidth*0.65, cellHeight*0.5)];
        nameLabel.text = name;
        nameLabel.textColor = [UIColor whiteColor];
        nameLabel.textAlignment = NSTextAlignmentCenter;
        nameLabel.adjustsFontSizeToFitWidth = YES;
        
        
        NSNumber *score = [playerInfo objectForKey:@"score"];
        UILabel *scoreLabel = [[UILabel alloc] init];
        [scoreLabel setFont:[UIFont fontWithName:@"Helvetica Neue" size:cellHeight*0.2]];
        [scoreLabel setFrame:CGRectMake(cellWidth*0.35, cellHeight*0.5, cellWidth*0.65, cellHeight*0.5)];
        scoreLabel.text = [NSString stringWithFormat:@"Score: %@", [score stringValue]];
        scoreLabel.textColor = [UIColor whiteColor];
        scoreLabel.textAlignment = NSTextAlignmentCenter;
        scoreLabel.adjustsFontSizeToFitWidth = YES;
        
        NSNumber *rank = [playerInfo objectForKey:@"rank"];
        UITextField *rankLabel = [[UITextField alloc] init];
        [rankLabel setFrame:CGRectMake(0, 0, cellWidth*0.15, cellHeight)];
        
        [rankLabel setFont:[UIFont fontWithName:@"Times New Roman" size:cellHeight*0.7]];
        rankLabel.text = [rank stringValue];
        rankLabel.layer.shadowOpacity = 1.0;
        rankLabel.layer.shadowRadius = 1.0;
        rankLabel.layer.shadowColor = [UIColor blackColor].CGColor;
        rankLabel.layer.shadowOffset = CGSizeMake(0.0, 2.0);
        rankLabel.textColor = [UIColor whiteColor];
        rankLabel.textAlignment = NSTextAlignmentCenter;
        rankLabel.adjustsFontSizeToFitWidth = YES;
        
        [self addSubview:self.playerImageView];
        [self addSubview:nameLabel];
        [self addSubview:scoreLabel];
        [self addSubview:rankLabel];
    }
    return self;
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
