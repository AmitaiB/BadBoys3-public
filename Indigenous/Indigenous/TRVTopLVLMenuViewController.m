////
////  TRVTopLVLMenuViewController.m
////  Indigenous
////
////  Created by Amitai Blickstein on 7/28/15.
////  Copyright (c) 2015 Bad Boys 3. All rights reserved.
////
//
//#import "TRVTopLVLMenuViewController.h"
//#import <MPSkewedCell.h>
//#import <MPSkewedParallaxLayout.h>
//
//static NSString *kCellID = @"cellID";
//
//@interface TRVTopLVLMenuViewController () <UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource>
//
//@property (nonatomic, strong) UICollectionView *collectionView;
//
//@end
//
//@implementation TRVTopLVLMenuViewController
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//    
//    self.navigationController.navigationBarHidden = YES;
//    
//    MPSkewedParallaxLayout *layout = [MPSkewedParallaxLayout new];
//    layout.lineSpacing = 2;
//    layout.itemSize = CGSizeMake(CGRectGetWidth(self.view.bounds), 250);
//    
//    self.collectionView                  = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
//    self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
//    self.collectionView.delegate         = self;
//    self.collectionView.dataSource       = self;
//    self.collectionView.backgroundColor  = [UIColor whiteColor];
//    [self.collectionView registerClass:[MPSkewedCell class] forCellWithReuseIdentifier:kCellID];
//    [self.view addSubview:self.collectionView];
//}
//
//-(void)viewDidLayoutSubviews {
//    [super viewDidLayoutSubviews];
//    [(MPSkewedParallaxLayout *)self.collectionView.collectionViewLayout setItemSize:CGSizeMake(CGRectGetWidth(self.view.bounds), 250)];
//}
//
//-(NSString *)titleForIndex:(NSInteger)index {
//    NSString *text = nil;
//    switch (index - 1) {
//        case 0:
//            text = @"EAT\n gimme some candy!";
//            break;
//        case 1:
//            text = @"DRINK\n but don't drink yellow snow";
//            break;
//        case 2:
//            text = @"SEE\n look but don't touch!";
//            break;
//        case 3:
//            text = @"PLAY\n with yourself, or with others";
//            break;
//        case 4:
//            text = @"EASTER EGG!\n Eat at Joe's...";
//            break;
//        default:
//            break;
//    }
//    return text;
//}
//
//#pragma mark - UICollectionViewDataSource
//
//-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    return 10; //random
//}
//
//-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//        NSInteger index    = indexPath.item % 5 + 1;
//        MPSkewedCell* cell = (MPSkewedCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kCellID
//                                                                                       forIndexPath:indexPath];
//        cell.image         = [UIImage imageNamed:[NSString stringWithFormat:@"%zd", index]];
//        cell.text          = [self titleForIndex:index];
//    
//    return cell;
//}
//
//#pragma mark - UICollectionViewDelegate
//
//-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"%@ %zd", NSStringFromSelector(_cmd), indexPath.item);
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
///*
//#pragma mark - Navigation
//
//// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//}
//*/
//
//@end
