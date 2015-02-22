//
//  projectTableViewController.m
//  banana
//
//  Created by Gaël on 22/02/2015.
//  Copyright (c) 2015 gael. All rights reserved.
//

#import "projectTableViewController.h"

@interface projectTableViewController ()

@end

@implementation projectTableViewController{

    NSArray * listProjet ;
    
}


-(void)ajoutProjet : (NSString *) libelle {
    
    NSManagedObject * newProjet;
    
    newProjet = [NSEntityDescription insertNewObjectForEntityForName: @"Projets" inManagedObjectContext:context];
    
    NSLog(@"id -> %ld", [self autoIncrementProject:@"Projets"]);
    
    NSNumber *idNumber = [NSNumber numberWithInt:[self autoIncrementProject:@"Projets"]];
    
    [newProjet setValue:libelle forKey:@"libelle_projet"];
    [newProjet setValue:idNumber forKey:@"id_projet"];
    
    
    [context save:nil];
}


-(NSInteger)autoIncrementProject : (NSString *) table{
    
    NSEntityDescription * query = [NSEntityDescription entityForName:table inManagedObjectContext:context];
    NSFetchRequest * request = [NSFetchRequest new];
    [request setEntity:query];
    
    NSError * error;
    NSArray * mesResultats = [context executeFetchRequest:request error:&error];
    if(error){
        NSLog(@"%@", error.description);
    }
    
    NSInteger newID = 0;
    
    for (NSDictionary *dict in mesResultats) {
        NSInteger IDToCompare = [[dict valueForKey:@"id_projet"] integerValue];
        
        if (IDToCompare >= newID) {
            newID = IDToCompare + 1;
        }
    }
    
    NSLog(@"new id -> %ld",newID);
    return newID;
    
}

//retourne le comptenu table
-(NSArray *)findListeProject
{
    
    NSEntityDescription * query = [NSEntityDescription entityForName:@"Projets" inManagedObjectContext:context];
    NSFetchRequest * request = [NSFetchRequest new];
    [request setEntity:query];
    
    NSError * error;
    NSArray * mesResultats = [context executeFetchRequest:request error:&error];
    if(error){
        NSLog(@"%@", error.description);
    }
    
    return mesResultats;
}




















- (void)viewDidLoad {
    [super viewDidLoad];
    // listProjet = [ NSArray arrayWithObjects:@"projet1",@"projet2", nil];
    
    NSLog(@"je fait un truc ou pas");
    
    //c'est pour un projet plus structuré ou l'on ecrase pas a chaque fois
    app = [[UIApplication sharedApplication] delegate];
    context = [app managedObjectContext];
    [self ajoutProjet:@"platre"];
    [self ajoutProjet:@"faire la plonge"];
    
    listProjet = [self findListeProject];
    
    NSLog(@"fini ajout ");
    
    
    
    
    
    
    
    
   
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 0;
   
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [listProjet count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //version pour base
    
    NSLog(@"je suis dans la fonction");
    static NSString *cellid = @"listProjetCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    NSMutableDictionary *dict = [listProjet objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [dict valueForKey:@"libelle_projet"];
    
    return cell;
    
    
    
    
    //version lionel
    /*
    static NSString *cellid = @"listProjetCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    
    
    cell.textLabel.text = listProjet[indexPath.row];
    
    return cell;
    */

}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
