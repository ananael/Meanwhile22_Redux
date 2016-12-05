//
//  SuggestionsViewController.m
//  Meanwhile22
//
//  Created by Michael Hoffman on 12/2/16.
//  Copyright © 2016 Here We Go. All rights reserved.
//

#import "SuggestionsViewController.h"
#import "MethodsCache.h"

@interface SuggestionsViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UIView *pageAccent;
@property (weak, nonatomic) IBOutlet UIButton *readButton;
@property (weak, nonatomic) IBOutlet UIButton *watchButton;
@property (weak, nonatomic) IBOutlet UIButton *previousButton;

- (IBAction)readTapped:(id)sender;
- (IBAction)watchTapped:(id)sender;
- (IBAction)previousTapped:(id)sender;

@end

@implementation SuggestionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.backgroundImage.image = [UIImage imageNamed:@"paper C lite"];
    
    MethodsCache *methods = [MethodsCache new];
    [methods createViewBorderWidth:2.0 color:[UIColor blackColor] forArray:[self viewArray]];
    [methods createButtonBorderWidth:2.0 color:[UIColor blackColor] forArray:[self buttonArray]];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSArray *)viewArray
{
    NSArray *views = @[self.pageAccent];
    return views;
}

-(NSArray *)buttonArray
{
    NSArray *buttons = @[self.readButton, self.watchButton, self.previousButton];
    return buttons;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)readTapped:(id)sender
{
    
}

- (IBAction)watchTapped:(id)sender
{
    
}

- (IBAction)previousTapped:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}















@end
