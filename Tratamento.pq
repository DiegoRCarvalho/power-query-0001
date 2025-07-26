let
    Fonte = Excel.Workbook(DadosConsolidados{6}[Content], true)[Data]{0},
    DadosAdicionaisAdd = Table.AddColumn(Fonte, "DadosAdicionais", each [
    Ano = "2025",
    Empresa = "EmpresaAbc"
], type [Ano = text, Empresa = text]),
    DadosAdicionaisExpandido = Table.ExpandRecordColumn(DadosAdicionaisAdd, "DadosAdicionais", {"Ano", "Empresa"}, {"Ano", "Empresa"}),
    Unpivot = Table.UnpivotOtherColumns(DadosAdicionaisExpandido, {"Cod item", "Ano", "Empresa"}, "Atributo", "Consumo"),
    LinhasFiltradas = Table.SelectRows(
        Unpivot, each 
        let
            __FinalAtributo = Text.AfterDelimiter([Atributo],"-")
        in
        Text.StartsWith([Atributo], "Cons") and 
        (
            __FinalAtributo = Text.End([Ano],2)
            or
            __FinalAtributo = ""
        )
    )
in
    LinhasFiltradas