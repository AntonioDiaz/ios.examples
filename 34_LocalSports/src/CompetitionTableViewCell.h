//
//  CompetitionTableViewCell.h
//  LocalSports
//
//  Created by Antonio Díaz Arroyo on 4/12/17.
//  Copyright © 2017 cice. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CompetitionTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labelCompetitionName;
@property (weak, nonatomic) IBOutlet UILabel *labelCategory;
@property (weak, nonatomic) IBOutlet UIView *viewCompetition;

@end
