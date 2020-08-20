
configfile: "config.yaml"


rule compile_cost_assumptions:
    input:
        pypsa_costs = "inputs/costs_PyPSA.csv",
        fraunhofer_costs = "inputs/Fraunhofer_ISE_costs.csv",
        fraunhofer_energy_prices = "inputs/Fraunhofer_ISE_energy_prices.csv",
        dea_transport = "inputs/energy_transport_data_sheet_dec_2017.xlsx",
        dea_renewable_fuels = "inputs/data_sheets_for_renewable_fuels_-_0003.xlsx",
        dea_storage = "inputs/technology_data_catalogue_for_energy_storage.xlsx",
        dea_generation = "inputs/technology_data_for_el_and_dh_-_0009.xlsx",
        dea_heating = "inputs/technologydatafor_heating_installations_marts_2018.xlsx",
        dea_industrial = "inputs/technology_data_for_industrial_process_heat_0001.xlsx"
    output:
        expand("outputs/costs_{year}.csv", year = config["years"])
    threads: 1
    resources: mem=500
    script: "scripts/compile_cost_assumptions.py"


rule convert_fraunhofer:
    input:
        fraunhofer = "docu/Anhang-Studie-Wege-zu-einem-klimaneutralen-Energiesystem.pdf"
    output:
        costs = "inputs/Fraunhofer_ISE_costs.csv",
        energy_prices = "inputs/Fraunhofer_ISE_energy_prices.csv"
    threads: 1
    resources: mem=500
    script: "scripts/convert_pdf_fraunhofer_to_dataframe.py"
