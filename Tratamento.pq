let
    Fonte = Excel.Workbook(DadosConsolidados{6}[Content], true)[Data]{0},
    #"Personalização Adicionada" = Table.AddColumn(Fonte, "DadosAdicionais", each [
    Ano = "2023",
    Empresa = "EmpresaAbc"
])
in
    #"Personalização Adicionada"