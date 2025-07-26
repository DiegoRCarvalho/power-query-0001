let
    Fonte = Excel.Workbook(DadosConsolidados{6}[Content], true)[Data]{0},
    DadosAdicionaisAdd = Table.AddColumn(Fonte, "DadosAdicionais", each [
    Ano = "2023",
    Empresa = "EmpresaAbc"
], type [Ano = text, Empresa = text]),
    DadosAdicionaisExpandido = Table.ExpandRecordColumn(DadosAdicionaisAdd, "DadosAdicionais", {"Ano", "Empresa"}, {"Ano", "Empresa"}),
    Unpivot = Table.UnpivotOtherColumns(DadosAdicionaisExpandido, {"Cod item", "Ano", "Empresa"}, "Atributo", "Consumo"),
    #"Linhas Filtradas" = Table.SelectRows(Unpivot, each Text.StartsWith([Atributo], "Cons"))
in
    #"Linhas Filtradas"