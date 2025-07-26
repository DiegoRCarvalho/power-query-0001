let
    Fonte = Excel.Workbook(DadosConsolidados{6}[Content], true)[Data]{0},
    DadosAdicionaisAdd = Table.AddColumn(Fonte, "DadosAdicionais", each [
    Ano = "2023",
    Empresa = "EmpresaAbc"
], type [Ano = text, Empresa = text]),
    DadosAdicionaisExpandido = Table.ExpandRecordColumn(DadosAdicionaisAdd, "DadosAdicionais", {"Ano", "Empresa"}, {"Ano", "Empresa"})
in
    DadosAdicionaisExpandido