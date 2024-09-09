from dagster import Definitions
from dagster_dbt import DbtCliResource
from .assets import dbt_core_dbt_assets
#from .project import dbt_core_project
from .constants import dbt_project_dir
from .schedules import schedules
import os

defs = Definitions(
    assets=[dbt_core_dbt_assets],
    schedules=schedules,
    resources={
        #"dbt": DbtCliResource(project_dir=dbt_core_project),
        "dbt": DbtCliResource(project_dir=os.fspath(dbt_project_dir)),
    },
)