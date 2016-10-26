//
//  Adaptive1Controller.m
//  VCellExample
//
//  Created by Vols on 2015/10/25.
//  Copyright © 2015年 Vols. All rights reserved.
//

#import "Adaptive1Controller.h"
#import "ContentCell.h"
#import "Content2Cell.h"
#import "ContentModel.h"

#import "VHttpHelper.h"

@interface Adaptive1Controller ()  <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView   * tableView;
@property (nonatomic, strong) NSMutableArray* dataSource;

@end

@implementation Adaptive1Controller

- (void)viewDidLoad {
    [super viewDidLoad];

    [self getDataRequestPage:@"2"];
    
//    [self testData];
    [self displayUIs];
    
    if (_adaptiveCellType == kAdaptiveCellTypeiOS8) {
        _tableView.rowHeight = UITableViewAutomaticDimension;
        [_tableView registerClass:[Content2Cell class] forCellReuseIdentifier:kContent2CellIdentifier];
    }
}


//测试数据
- (void)testData{
    for (int i = 0; i < 10; i ++) {
        ContentModel * model = [[ContentModel alloc] init];
        model.user.login = @"大熊";
        model.published_at = @"1477431902";
        model.content = i%2?@"高通与小米达成专利授权协议的主要影响在于小米的海外市场，因为在国内小米并不会遇到专利问题。然而，分析小米在海外遇到的问题会发现，这远不是签订一个专利协议能解决":@"大家好，我是他主治医生。请原谅他，他因为神经病引起的并发症迷恋上了装逼，去年高考 ，他差一点就上清华了，现在想来依然倍感惋惜，清华分数695，他考了69.5，就差那么一点。巨大的打击彻底粉碎了他对未来的憧憬，整日在家自暴自弃专研怎么装逼，终成为新一代装逼大师，将装逼 方法研究的出神入化，各种装逼方法，无死角装逼，终于横空出世…。你看，他又在装逼.......";
        [self.dataSource addObject:model];
    }
}

- (void)displayUIs {
    self.view.backgroundColor = [UIColor purpleColor];
    self.title = @"糗事百科";
    [self.view addSubview:self.tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(2, 2, 2, 2));
    }];
    
    _tableView.rowHeight = UITableViewAutomaticDimension;
}

#pragma mark - getters


- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}


- (UITableView *)tableView{
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        [_tableView registerClass:[ContentCell class] forCellReuseIdentifier:kContentCellIdentifier];
        _tableView.estimatedRowHeight = 120;    //预估行高 可以提高性能
    }
    return _tableView;
}


#pragma mark - UITableViewDelegate Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;

}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ContentModel *model = self.dataSource[indexPath.row];
    return  [model.cellHeight floatValue];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_adaptiveCellType == kAdaptiveCellTypeiOS7) {
        
        ContentCell * cell = [tableView dequeueReusableCellWithIdentifier:kContentCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model =  ((ContentModel *)self.dataSource[indexPath.row]);
        return cell;
 
    } else if (_adaptiveCellType == kAdaptiveCellTypeiOS8) {
    
        Content2Cell * cell = [tableView dequeueReusableCellWithIdentifier:kContent2CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model =  ((ContentModel *)self.dataSource[indexPath.row]);
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    ReportDetailController * reportDetailVC = [[ReportDetailController alloc] init];
//    reportDetailVC.model = ((ReportModel *)self.dataSource[indexPath.row]);
//    [self.navigationController pushViewController:reportDetailVC animated:YES];
}



#pragma mark - HttpRequest

//获取数据
- (void)getDataRequestPage:(NSString *)page{
    
    //    [self.parent showHud];
    NSDictionary * parmas = @{@"count":@"30", @"page":page};
    
    [[VHttpHelper shared] get:parmas path:@"article/list/text" success:^(id responseObject) {
        
        [self handleData:responseObject];
        
    } failue:^(NSError *error) {

    }];
}


//处理返回数据
- (void)handleData:(NSDictionary *)dic {
    if (self.dataSource.count>0)
        [self.dataSource removeAllObjects];

    NSArray * contentArray = dic[@"items"];
    for (NSDictionary *parmasDict in contentArray) {
        ContentModel* model = [[ContentModel alloc] initWithDictionary:parmasDict error:nil];
        [self.dataSource addObject:model];
    }
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
