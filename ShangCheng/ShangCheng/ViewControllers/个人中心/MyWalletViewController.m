//
//  MyWalletViewController.m
//  ShangCheng
//
//  Created by TongLi on 2017/2/7.
//  Copyright © 2017年 TongLi. All rights reserved.
//

#import "MyWalletViewController.h"
#import "MyWalletTableViewCell.h"
#import "Manager.h"
#import "MyTradeRecordViewController.h"

@interface MyWalletViewController ()<UITableViewDataSource,UITableViewDelegate>
//TableView
@property (weak, nonatomic) IBOutlet UITableView *myWalletTableView;
@property (nonatomic,strong)NSMutableArray *dataSource;
//账户余额label
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
//可提现Label
@property (weak, nonatomic) IBOutlet UILabel *amountAvailLabel;
//冻结金额Label
@property (weak, nonatomic) IBOutlet UILabel *amountFrozenLabel;


@end

@implementation MyWalletViewController


- (IBAction)leftBarButtonAction:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    NSMutableDictionary *dic11 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"w_icon_withdraw",@"myWalletImg",@"提现",@"myWalletTitle",@"---",@"myWalletRight",@"walletToAgentCashVC",@"pushId", nil];
    NSDictionary *dic12 = @{@"myWalletImg":@"w_icon_recharge",@"myWalletTitle":@"充值",@"pushId":@"walletToRechargeVC"};
    NSMutableArray *dataArr1 = [NSMutableArray arrayWithObjects:dic11 ,dic12, nil];
    
    NSDictionary *dic21 = @{@"myWalletImg":@"w_icon_yhq",@"myWalletTitle":@"优惠卷",@"pushId":@"myWalletToCouponVC"};
    NSMutableArray *dataArr2 = [NSMutableArray arrayWithObjects:dic21, nil];
    
    NSDictionary *dic31 = @{@"myWalletImg":@"w_icon_txjl",@"myWalletTitle":@"交易记录",@"pushId":@"myWalletToTradeRecordVC"};
    NSDictionary *dic32 = @{@"myWalletImg":@"w_icon_jxjl",@"myWalletTitle":@"提现记录",@"pushId":@"myWalletToTradeRecordVC"};
    NSMutableArray *dataArr3 = [NSMutableArray arrayWithObjects:dic31,dic32, nil];
    
    self.dataSource = [NSMutableArray arrayWithObjects:dataArr1,dataArr2,dataArr3, nil];
    
    //请求余额信息
    //查询账户余额
    Manager *manager = [Manager shareInstance];
    [manager searchUserAmount:manager.memberInfoModel.u_id withAmountSuccessBlock:^(id successResult) {
        
        //将最新的余额存入模型中
        
        manager.memberInfoModel.u_amount = [[[successResult objectAtIndex:0] objectForKey:@"u_amount"] doubleValue];
        manager.memberInfoModel.u_amount_avail = [[[successResult objectAtIndex:0] objectForKey:@"u_amount_avail"] doubleValue];
        manager.memberInfoModel.u_amount_frozen = [[[successResult objectAtIndex:0] objectForKey:@"u_amount_frozen"] doubleValue];
        
        //将可提现的金额放入DataSource中
        [[self.dataSource[0] objectAtIndex:0]setObject:[NSString stringWithFormat:@"%.2f",manager.memberInfoModel.u_amount_avail] forKey:@"myWalletRight"];
        
        //刷新UI
        [self updateHeadViewAction];
        
        [self.myWalletTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];//刷新可提现cell
        
        
    } withAmountFailBlock:^(NSString *failResultStr) {
        
    }];
    

}


- (void)updateHeadViewAction {
    Manager *manager = [Manager shareInstance];
    
    self.amountLabel.text = [NSString stringWithFormat:@"%.2f", manager.memberInfoModel.u_amount];
    self.amountAvailLabel.text = [NSString stringWithFormat:@"%.2f",manager.memberInfoModel.u_amount_avail];
    self.amountFrozenLabel.text = [NSString stringWithFormat:@"%.2f",manager.memberInfoModel.u_amount_frozen];

    
}


#pragma mark - tabelView -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return  self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource[section] count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *tempDic = [self.dataSource[indexPath.section] objectAtIndex:indexPath.row];
    
    MyWalletTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myWalletCell" forIndexPath:indexPath];
    
    [cell updateMyWalletCellWithDataJson:tempDic];
    
    return cell;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *tempDic = [self.dataSource[indexPath.section] objectAtIndex:indexPath.row];

    
    NSString *pushId = [tempDic objectForKey:@"pushId"];
    if (pushId.length > 0) {
        
        [self performSegueWithIdentifier:pushId sender:indexPath];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    //提现记录
    if ([segue.identifier isEqualToString:@"myWalletToTradeRecordVC"]) {
        NSIndexPath *tempIndex = (NSIndexPath *)sender;
        MyTradeRecordViewController *myTradeRecordVC = [segue destinationViewController];
        if (tempIndex.row == 0) {
            //交易记录
            myTradeRecordVC.isCash = NO;
        }else {
            //提现记录
            myTradeRecordVC.isCash = YES;
            
        }
    }
    
    //充值
    if ([segue.identifier isEqualToString:@"walletToRechargeVC"]) {
        
        
    }
    
}


@end
