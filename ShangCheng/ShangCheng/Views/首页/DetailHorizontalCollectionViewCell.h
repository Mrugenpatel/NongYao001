//
//  DetailHorizontalCollectionViewCell.h
//  ShangCheng
//
//  Created by TongLi on 2016/10/28.
//  Copyright © 2016年 TongLi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductModel.h"

@interface DetailHorizontalCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *upProductImageView;
@property (weak, nonatomic) IBOutlet UIImageView *upSaleImageView;
@property (weak, nonatomic) IBOutlet UILabel *upProductTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *upProductFormatLabel;
@property (weak, nonatomic) IBOutlet UILabel *upProductPriceLabel;

@property (weak, nonatomic) IBOutlet UIImageView *downProductImageView;
@property (weak, nonatomic) IBOutlet UIImageView *downSaleImageView;
@property (weak, nonatomic) IBOutlet UILabel *downProductTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *downProductFormatLabel;
@property (weak, nonatomic) IBOutlet UILabel *downProductPriceLabel;


- (void)updateDetailHorizontalCollectionViewCellWithUpModel:(ProductModel *)upModel withDownModel:(ProductModel *)downModel;



@end
