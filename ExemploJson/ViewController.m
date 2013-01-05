//
//  ViewController.m
//  ExemploJson
//
//  Created by Rafael Brigagão Paulino on 03/10/12.
//  Copyright (c) 2012 rafapaulino.com. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    @try
    {
        //local do arquivo
        NSString *pathArquivo = [[NSBundle mainBundle] pathForResource:@"dados" ofType:@"json"];
        
        //criando um nsdata a partir do arquivo json
        NSData *dadosJSON = [[NSData alloc] initWithContentsOfFile:pathArquivo];
        
        //chamada para transformar um arquivo serializado (NSData) em uma estrutura de dados que conhecemos (array ou dictionary)
        id objetoJSON = [NSJSONSerialization JSONObjectWithData:dadosJSON options:NSJSONReadingAllowFragments error:nil];
        
        NSDictionary *dicionarioJSON;
        
        //verificando se o bjeto criado na linha anterior é do tipo NSDictionary
        if ([objetoJSON isKindOfClass:[NSDictionary class]])
        {
            //utilizando um ponteiro de tipo especifico para o objeto que antes era um id
            dicionarioJSON = (NSDictionary*)objetoJSON;
        }
        
        if (objetoJSON == nil)
        {
            NSException *exception = [[NSException alloc] initWithName:@"Dicionario nulo" reason:@"Dicionario ficou nulo na serializacao" userInfo:nil];
           
            @throw exception;
        }
        
        NSLog(@"Dados do dicionario: %@", dicionarioJSON.description);
        
        //neste ponto vc ja pode usar os dados e uma tabela, ou qualquer outro aplicativo
        NSArray *listaEmpregados = [dicionarioJSON objectForKey:@"empregados"];
        
        NSLog(@"Dados do dicionario (array): %@", listaEmpregados.description);
        
        
        //lista de empregados (foreach)
        for (NSDictionary *dicionario in listaEmpregados) {
            NSLog(@"Primeiro nome: %@ \n\r", [dicionario objectForKey:@"nome"]);
        }
        
        
        
        //testando a exception
        NSException *exception = [[NSException alloc] initWithName:@"Palhacitos" reason:@"O programador comeu palhacitos" userInfo:nil];
        
        @throw exception;
        
        
    }
    @catch (NSException *exception)
    {
        if ([exception.name isEqualToString:@"Dicionario nulo"])
        {
            NSLog(@"Arquivo corrompido: %@", exception.description);
        }
        else
        {
            NSLog(@"Erro: %@ - %@", exception.name,exception.description);
        }
        
    }
    /*
     é opcional
     @finally 
     {
        
     }
     */
    
    
    //mao inversa - passar um objeto NSArray ou NSDictionary para um arquivo JSON
    NSArray *listaParaGravacao = [NSArray arrayWithObjects:@"Eduardo",@"Rafael",@"Alessandro",@"Viviane",@"Gustavo", nil];
    
    NSData *dadosParaGravacao = [NSJSONSerialization dataWithJSONObject:listaParaGravacao options:NSJSONReadingAllowFragments error:nil];
    
    NSString *caminhoArquivo = [NSHomeDirectory() stringByAppendingString:@"/Documents/exemploGravacao.json"];
    
    [dadosParaGravacao writeToFile:caminhoArquivo atomically:YES];
    
    //onde salvou
    NSLog(@"Arquivo salvo: %@", caminhoArquivo);
   
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
