//
//  ViewController.m
//  VCellExample
//
//  Created by Vols on 2015/10/25.
//  Copyright © 2015年 Vols. All rights reserved.
//

#import "ViewController.h"

#import "Adaptive1Controller.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSArray * data1Source;
@property (nonatomic, strong) NSArray * data2Source;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initData];
    self.title = @"TableViewCell";
    [self.view addSubview:self.tableView];   //会自动调用 (UITableView *)tableView
}

- (void)initData{
    _data1Source = @[@"Adaptive Cell --> After iOS8", @"Adaptive Cell --> After iOS7"];
    _data2Source = @[@"StyleDefault", @"StyleDefault", @"StyleDefault", @"StyleDefault", @"StyleDefault"];
}


- (UITableView *)tableView{
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

#pragma mark - UITableViewDelegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section ? _data2Source.count : _data1Source.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * identifier = @"cell_identifier";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if (indexPath.section == 0) {
        cell.textLabel.text = _data1Source[indexPath.row];
    } else {
        cell.textLabel.text = _data2Source[indexPath.row];
    }
    
    return cell;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return section ? @"待定类型":@"自适应Cell";
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        Adaptive1Controller * adaptiveVC = [[Adaptive1Controller alloc] init];
        adaptiveVC.adaptiveCellType = indexPath.row;
        [self.navigationController pushViewController:adaptiveVC animated:YES];
    }
    
    
    [self performSelector:@selector(deselect:) withObject:tableView afterDelay:0.2f];
}

- (void)deselect:(UITableView *)tableView {
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
