//
//  MainTableViewController.m
//  Table View Plist
//
//  Created by Anderson Tagata on 23/07/15.
//  Copyright (c) 2015 Anderson Tagata. All rights reserved.
//

#import "MainTableViewController.h"

@interface MainTableViewController ()

@end

// ATT 1.1  - Repare que como essa classe foi criada como subclasse de UITableViewController
//            automaticamente vem com os métodos da table view implementados com o minimo necessario.
//
@implementation MainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // ATT 2.1 - Carregando dados na propriedade a partir de um array fixo usando o método abaixo:
    //
    //self.dataList = [NSArray arrayWithObjects:@"Banana", @"Maça", @"Laranja", @"Uva", @"Limão", @"jaca", nil];
    //  Trazendo um array de um metodo que le de um arquivo .plist
    
    
    // -------------------
    // Forma 1 de juntar arrays com mais codigo [NSArray arrayByAddingObjectsFromArray:(NSArray *)]
    NSArray * frutasArray = [self loadArrayFromPlist:@"Frutas"];
    
    NSArray * legumesArray = [self loadArrayFromPlist:@"Legumes"];
    
    self.dataList = [frutasArray arrayByAddingObjectsFromArray:legumesArray];
    
    
    // -------------------
    // Forma 2 de juntar arrays com menos codigo, chamamos de aninhar metodos.
    //self.dataList = [[self loadArrayFromPlist:@"Frutas"] arrayByAddingObjectsFromArray:[self loadArrayFromPlist:@"Legumes"]];
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    //
    // ATT 2.2 - Definir aqui o return para 1, indicando que a tabela tera apenas 1 seção.
    //           Multiplas seções são usadas em aplicativos como o de Contatos,
    //           onde cada letra do alfabeto cria um grupo de nomes, ou seja, seção.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    // ATT 2.3 - Definir aqui a contagem de itens do array usando o método count,
    //           assim a tabela saberá quantas celulas serão montadas.
    return [self.dataList count];
}

// ATT 2.4 - Importante! Descomente esse método para uso!
//           Ele é responsável pela montagem de cada célula da tabela, uma a uma.
//           E voce pode tambem personalizar a celula antes dela ser inserida na tabela.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // ATT 2.4.1 - DEFININDO O CELL WITH IDENTIFIER - IMPORTANTE!
    //             Vá até o StoryBoard, Selecione a Celula Prototipo e mude o Identifier para @"Cell"
    //             Depois mude abaixo para @"Cell" tambem
    //             Ou seja, ao montar uma nova célula, que a mesma seja uma cópia da protótipo.
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    // ATT 2.4.2 - Caso queira tratar linhas da tabela separadamente, voce pode aplicar um teste
    //             lógico no indexPath.row como no exemplo a seguir.
    //             Assim vc pode personalizar uma célula diferentemente das outras.
    /*
    if (indexPath.row == 0) {
        cell.textLabel.text = @"Item 0";
    }
    else {
        cell.textLabel.text = @"Item";
    }
     */
    
    // ATT 2.4.3 - Personalizando a célula
    //             Buscando o texto (object) em um dado indice(index) do array
    //             usando o método do NSArray chamado objectAtIndex:
    //             e passando como argumento a linha da tabela atual (indexPath.row)
    //             Como o Objecto retornado é uma NSString, podemos passar direto para a propriedade
    //             text do Label da Celula.
    cell.textLabel.text = [self.dataList objectAtIndex:indexPath.row];
    
    // ATT 2.4.4 - IMPORTANTE! Sempre ao final retornar a instancia da cell montada.
    //
    return cell;
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

#pragma mark - Plist Manager

//Carrega array de um Plist passado como parametro.
-(NSArray *) loadArrayFromPlist:(NSString *)plistName{
    //Caso o plistName vier nulo, retornar nulo com mensagem no Log
    if (plistName==nil) {
        NSLog(@"Nome do Plist não foi informado! Use apenas a string com o nome sem .plist");
        return nil;
    }
    
    //Verificando a existencia e a localizacao do plist no bundle
    NSString *path = [[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"];
    
    if (path == nil) {
        NSLog(@">> ERRO: O %@ Plist não foi encontrado no Main Bundle", plistName);
        return nil;
    }
    else{
        NSLog(@"Caminho do plist:%@",path);
    }
    
    //Retornar um array com o conteudo do array do plist
    return [NSArray arrayWithContentsOfFile:path];
}

@end
