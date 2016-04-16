//
//  LQVedioCell.m
//  Spice
//
//  Created by lanou3g on 16/4/15.
//  Copyright © 2016年 spice. All rights reserved.
//

#import "LQVedioCell.h"
#import "LQVedion.h"
#import <UIImageView+WebCache.h>
@interface LQVedioCell ()

@property (weak, nonatomic) IBOutlet UIImageView *vedioImage;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIButton *vontButton;

@property (weak, nonatomic) IBOutlet UIButton *playCountButton;

@property (weak, nonatomic) IBOutlet UIButton *commentCountButton;
@end


@implementation LQVedioCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.vedioImage sd_setImageWithURL:[NSURL URLWithString:self.vedio.image] placeholderImage:nil];
        self.titleLabel.text = self.vedio.title;
        [self.vontButton setTitle:[NSString stringWithFormat:@"%@",self.vedio.vote_count] forState:UIControlStateNormal];
        [self.playCountButton setTitle:[NSString stringWithFormat:@"%@",self.vedio.play_count] forState:UIControlStateNormal];
        [self.commentCountButton setTitle:[NSString stringWithFormat:@"%@",self.vedio.comment_count] forState:UIControlStateNormal];
        
    }
    return self;
}


+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *reuseID = @"cell";
    LQVedioCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (cell == nil) {
        cell = [[LQVedioCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
    }
    return cell;
}




@end
