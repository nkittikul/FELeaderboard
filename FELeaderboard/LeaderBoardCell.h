//
//  LeaderBoardCell.h
//  FELeaderboard
//
//  Created by Narin Kittikul on 10/14/14.
//  Copyright (c) 2014 Narin Kittikul. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeaderBoardCell : UITableViewCell
@property (nonatomic, strong) UIImageView *playerImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *scoreLabel;
@property (nonatomic, strong) UILabel *rankLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
- (void) getPlayerImageFromRequest:(NSURLRequest *) request;

@end
