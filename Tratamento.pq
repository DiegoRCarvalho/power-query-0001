let
    Fonte = DadosConsolidados{6}[Content],
    #"Pasta de Trabalho Importada do Excel" = Excel.Workbook(Fonte, true)[Data]{0}
in
    #"Pasta de Trabalho Importada do Excel"