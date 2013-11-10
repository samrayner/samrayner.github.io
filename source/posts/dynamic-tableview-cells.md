---
title: "Dynamic Height UITableView Cells in Xcode"
date: 2012-10-24 16:59
tags: mac, ios, development
banner_image: banner.jpg
banner_height: 285
banner_color: white
---

I recently started building my first iOS app and quickly ran into problems trying to apply dynamic heights to `UITableView` cells depending on their content. This seems like the kind of common task that Apple would make simple through their APIs but after hours of research I discovered that:

1. This is [an extremely common problem][so].
2. There is no single, agreed-upon solution.
3. Existing solutions ([this one from Cocoa is My Girlfriend][cimg] seems to be the most widely linked to) appear to involve a lot of code repetition.

Frustrated, I became determined to create my own solution. The goals:

1. Use a custom `UITableViewCell` NIB designed in Interface Builder and only adjust things in code when necessary.
2. Be able to easily apply the custom cell to table views in my app Storyboard.
3. Avoid code repetition wherever possible. We're going to need to calculate heights once for the row then again for the cell so let's streamline that.

Here's what I came up with.

Prepare a Prototype Cell
------------------------
First, create a new Empty User Interface. Drag a `UITableViewCell` object in, fill it with subviews and arrange them to your liking. You'll probably want to set the cell Style to Custom in the Attributes inspector. This is your _prototype cell_; styles and positioning will be inherited from it.

I took the approach of including everything that could be shown in the cell in my NIB so I can hide rather than add elements in code later. Make sure your constraints are set up nicely to allow for the height of your cell changing[^1].

Next, create an Objective-C class that extends `UITableViewCell` and add properties to its header file for all of the cell elements you'll want access to in your `UITableViewController` later:

    @interface NaSQuotationTableViewCell : UITableViewCell
      @property (weak) IBOutlet UILabel *quotationLabel, *attributionLabel;
      @property (weak) IBOutlet UIButton *avatarButton, *imageButton;
    @end

Go back to your NIB, select your cell, and hook up the `IBOutlet`s in the Connections inspector by ctrl-dragging onto the appropriate subviews.

Finally, set the following on both the cell in your NIB _and_ the prototype cell in each `UITableView` of your Storyboard.

- Change the Custom Class in the Identity inspector to your newly created class (`NaSQuotationTableViewCell`).
- Give it a unique Identifier in the Attributes inspector. Mine is `QuotationCell`.

Apply Dynamic Cell Heights
--------------------------
The first thing you'll want to do is import the new cell class in the header of your `UITableViewController`:

    #import <UIKit/UIKit.h>
    #import "NaSQuotationTableViewCell.h"

    @interface NaSQuotationsTableViewController : UITableViewController<UITableViewDelegate,UITableViewDataSource>
    @end

In the implementation file of your `UITableViewController`, add a property for your cell prototype:

    @interface NaSQuotationsTableViewController ()
      @property (strong) NaSQuotationTableViewCell *cellPrototype;
      @property NSArray *quotes, *names; //for dummy content
    @end

Then load the prototype NIB when the view loads:
    - (void)viewDidLoad {
      [super viewDidLoad];
      //load prototype table cell nib
      static NSString *CellIdentifier = @"QuotationCell";
      [self.tableView registerNib:[UINib nibWithNibName:@"NaSQuotationTableViewCell" bundle:nil] forCellReuseIdentifier:CellIdentifier];
      self.cellPrototype = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];

      //fill dummy content
      self.quotes = [NSArray arrayWithObjects:@"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla hendrerit quam eu nisl pellentesque aliquam.", @"Vestibulum ligula quam, gravida ut convallis semper, bibendum in turpis.", @"Nam quis sapien purus.", @"Donec suscipit lectus in arcu eleifend ac posuere lacus egestas. Nunc gravida quam in urna ultricies at pharetra magna sodales. Nulla placerat mi tincidunt nulla posuere id interdum mi pretium. Aliquam nulla tortor, egestas pharetra sollicitudin a, sagittis ut enim. Vivamus venenatis consectetur commodo.", @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla hendrerit quam eu nisl pellentesque aliquam. Vestibulum ligula quam, gravida ut convallis semper, bibendum in turpis. Nam quis sapien purus. Nunc tincidunt eleifend porta. Donec suscipit lectus in arcu eleifend ac posuere lacus egestas. Nunc gravida quam in urna ultricies at pharetra magna sodales.", nil];

      self.names = [NSArray arrayWithObjects:@"Sam Rayner", @"Sam Millner", @"Rob White", @"Dom Wroblewski", @"Jack Smith", nil];
    }

Now we have access to the prototype cell labels, we can pass their attributes into `NSString`'s `sizeWithFont:` method to calculate the required row height:

    - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
      return [self.quotes count];
    }

    - (NSString *)quotationTextForRow:(int)row {
      return [self.quotes objectAtIndex:row];
    }

    - (NSString *)attributionTextForRow:(int)row {
      return [@"– " stringByAppendingString:[self.names objectAtIndex:row]];
    }

    - (CGSize)sizeOfLabel:(UILabel *)label withText:(NSString *)text {
     return [text sizeWithFont:label.font constrainedToSize:label.frame.size lineBreakMode:label.lineBreakMode];
    }

    - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
      //set width depending on device orientation
      self.cellPrototype.frame = CGRectMake(self.cellPrototype.frame.origin.x, self.cellPrototype.frame.origin.y, tableView.frame.size.width, self.cellPrototype.frame.size.height);
      
      CGFloat quotationLabelHeight = [self sizeOfLabel:self.cellPrototype.quotationLabel withText:[self quotationTextForRow:indexPath.row]].height;
      CGFloat attributionLabelHeight = [self sizeOfLabel:self.cellPrototype.attributionLabel withText:[self attributionTextForRow:indexPath.row]].height;
      CGFloat padding = self.cellPrototype.quotationLabel.frame.origin.y;
      
      CGFloat combinedHeight = padding + quotationLabelHeight + padding/2 + attributionLabelHeight + padding;
      CGFloat minHeight = padding + self.cellPrototype.avatarButton.frame.size.height + padding;
      
      return MAX(combinedHeight, minHeight);
    }

We can reuse `sizeOfLabel:` in `tableView:cellForRowAtIndexPath:` to render the labels with the correct heights:

    - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
      //register cell identifier from custom cell NIB
      static NSString *CellIdentifier = @"QuotationCell";
      NaSQuotationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
      
      //set width depending on device orientation
      cell.frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y, tableView.frame.size.width, cell.frame.size.height);
      
      CGFloat quotationLabelHeight = [self sizeOfLabel:cell.quotationLabel withText:[self quotationTextForRow:indexPath.row]].height;
      CGFloat attributionLabelHeight = [self sizeOfLabel:cell.attributionLabel withText:[self attributionTextForRow:indexPath.row]].height;
      
      cell.quotationLabel.frame = CGRectMake(cell.quotationLabel.frame.origin.x, cell.quotationLabel.frame.origin.y, cell.quotationLabel.frame.size.width, quotationLabelHeight);
      cell.quotationLabel.text = [self quotationTextForRow:indexPath.row];
      
      cell.attributionLabel.frame = CGRectMake(cell.attributionLabel.frame.origin.x, cell.attributionLabel.frame.origin.y, cell.attributionLabel.frame.size.width, attributionLabelHeight);
      cell.attributionLabel.text = [self attributionTextForRow:indexPath.row];
      
      return cell;
    }

There we have it! Dynamic table cell heights depending on the text included in them. Hopefully this will give you a decent starting point for achieving the look you want in your app. Good luck!

[^1]: I confused myself for a good twenty minutes by applying a height _Equal_ constraint to a `UILabel` and wondering why changing the frame height in code wasn't having any affect. Cheers to my mate Sam for pointing out I wanted _Less Than or Equal_.

[so]: http://stackoverflow.com/search?q=tableview%20cell%20height
[cimg]: http://www.cimgf.com/2009/09/23/uitableviewcell-dynamic-height/
