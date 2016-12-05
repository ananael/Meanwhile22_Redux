//
//  BiosViewController.m
//  Meanwhile22
//
//  Created by Michael Hoffman on 11/30/16.
//  Copyright © 2016 Here We Go. All rights reserved.
//

#import "BiosViewController.h"
#import "MethodsCache.h"
#import "Biographies.h"

@interface BiosViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UIView *pageAccent;
@property (weak, nonatomic) IBOutlet UIView *bannerContainer;
@property (weak, nonatomic) IBOutlet UIImageView *bannerImage;
@property (weak, nonatomic) IBOutlet UIView *scrollContainer;
@property (weak, nonatomic) IBOutlet UILabel *biosLabel;

@property NSInteger hostSelect;

@property (weak, nonatomic) IBOutlet UIButton *previousButton;
@property (weak, nonatomic) IBOutlet UIButton *recommendButton;

- (IBAction)previousTapped:(id)sender;
- (IBAction)recommendTapped:(id)sender;

@end

@implementation BiosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.backgroundImage.image = [UIImage imageNamed:@"paper A lite"];
    self.pageAccent.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.7];
    
    MethodsCache *methods = [MethodsCache new];
    [methods createViewBorderWidth:2.0 color:[UIColor blackColor] forArray:[self viewArray]];
    [methods createButtonBorderWidth:2.0 color:[UIColor blackColor] forArray:[self buttonArray]];
    
    self.hostSelect = [[NSUserDefaults standardUserDefaults]integerForKey:@"HostSaved"];
    
    [self biosSelection];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSArray *)viewArray
{
    NSArray *views = @[self.bannerContainer, self.scrollContainer];
    return views;
}

-(NSArray *)buttonArray
{
    NSArray *buttons = @[self.previousButton, self.recommendButton];
    return buttons;
}

-(void)biosSelection
{
    Biographies *bios = [Biographies new];
    
    switch (self.hostSelect)
    {
        case 1:
            self.biosLabel.text = [bios capBios];
            [self.recommendButton setTitle:@"Cap Recommends ..." forState:UIControlStateNormal];
            break;
        case 2:
            self.biosLabel.text = [bios mfgBios];
            [self.recommendButton setTitle:@"MFG Recommends ..." forState:UIControlStateNormal];
            break;
        case 3:
            self.biosLabel.text = [bios ralfBios];
            [self.recommendButton setTitle:@"Ralph Recommends ..." forState:UIControlStateNormal];
            break;
            
        default:
            break;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)previousTapped:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)recommendTapped:(id)sender
{
    
}















@end
