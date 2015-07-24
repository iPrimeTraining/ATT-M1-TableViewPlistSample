//
//  MainTableViewController.h
//  Table View Plist
//
//  Created by Anderson Tagata on 23/07/15.
//  Copyright (c) 2015 Anderson Tagata. All rights reserved.
//

#import <UIKit/UIKit.h>

// ATT - 1.0 - Informar qual o Delegate e DataSource entre <>
//       Obs: mesmo que seja derivado de uma UITableViewController, é recomendado colocar como
//            uma forma de lembrar que eles existem e são utilizados no .m
//
@interface MainTableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>

// ATT - 2.0 - Crie uma propriedade para armazenar o array com os dados que serão utilizados
//            na Table View. Caso os dados possam ser alterados durante a execução do aplicativo
//            sera necessario então ser do tipo NSMutableArray
//       Obs: O nome dataList pode ser o nome que vc quiser utilizar.
//
@property (strong, nonatomic) NSArray * dataList; //Contem a lista de itens (fonte de dados)

//Carrega array de um Plist passado como parametro.
-(NSArray *) loadArrayFromPlist:(NSString *)plistName;

@end
