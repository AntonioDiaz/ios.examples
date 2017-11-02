//
//  main.m
//  CursoAntonio
//
//  Created by cice on 25/10/17.
//  Copyright © 2017 cice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#define PORCENTAJE_TEORIA 30
#define PORCENTAJE_PRACTICA 70
#define MINIMO_PRACTICA 4
#define TAM_EXAMENES 5

@interface Curso:NSObject
    +(BOOL)calculateCourseNote:(int[]) notasTeoria conNumerosTeoricos:(int) notasTeoriaSize  conPractico:(int) notaPractica withError:(NSError **)errorPtr;
@end

@implementation Curso
+(BOOL)calculateCourseNote:(int[]) notasTeoria conNumerosTeoricos:(int) notasTeoriaSize conPractico:(int) notaPractica withError:(NSError **)errorPtr {
    NSLog(@"calculateCourse ");
    if (notasTeoriaSize!=TAM_EXAMENES) {
        NSString *domain = @"com.MyCompany.MyApplication.ErrorDomain";
        NSString *desc =@"Wrong number of elements in the array.";
        NSDictionary *userInfo = [[NSDictionary alloc]
                                  initWithObjectsAndKeys:desc,
                                  @"NSLocalizedDescriptionKey", nil];
        *errorPtr = [NSError errorWithDomain:domain code:-101 userInfo:userInfo];
        return 0;
    }
    if(notaPractica<MINIMO_PRACTICA) {
        NSLog(@"No has aprobado");
        return false;
    }
    int sumaTeoria = 0;
    for (int i=0; i<notasTeoriaSize; i++) {
        NSLog(@"pasa %d", i);
        sumaTeoria += notasTeoria[i];
    }
    float notaTeoriaMedia = sumaTeoria / notasTeoriaSize;
    float notaFinal = notaTeoriaMedia*PORCENTAJE_TEORIA/100 + notaPractica*PORCENTAJE_PRACTICA/100;
    NSString *mensajeNotaFinal = [NSString stringWithFormat:@"Tu nota ha sido: %1.2f", notaFinal];
    NSLog([mensajeNotaFinal uppercaseString]);
    if (notaTeoriaMedia>=5) {
        return true;
    } else {
        return false;
    }
}
@end

int main(int argc, char * argv[]) {
    @autoreleasepool {
        NSLog(@"Evaluation: ");
        int notaPractico = 8;
        int notasTeoricas[] = {4,7,9,0,3};
        NSError *error = nil;
        BOOL isApto =[Curso calculateCourseNote:notasTeoricas conNumerosTeoricos:6 conPractico:notaPractico withError:&error];
        if(error){
            NSLog(@"Error finding Name1: %@",error);
        } else {
            if(isApto){
                NSLog(@"Apto");
            } else {
                NSLog(@"No apto");
            }
        }
    }
}
