//
//  SelectCouponViewController.h
//  ShangCheng
//
//  Created by TongLi on 2016/12/11.
//  Copyright © 2016年 TongLi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CouponDicBlock)(NSDictionary *couponDicBlock);

@interface SelectCouponViewController : UIViewController
//要支付的产品数组
@property (nonatomic,strong)NSMutableArray *previewOrderProductArr;

//block传值，将优惠金额传回预订单界面
@property (nonatomic,copy)CouponDicBlock couponDicBlock;

@end
