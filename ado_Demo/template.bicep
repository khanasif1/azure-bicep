param workflows_ado_api_name string = 'ado_api'
param connections_microsoftforms_name string = 'microsoftforms'
param workflows_ado_cascadeform_name string = 'ado_cascadeform'
param connections_visualstudioteamservices_name string = 'visualstudioteamservices'

resource connections_microsoftforms_name_resource 'Microsoft.Web/connections@2016-06-01' = {
  name: connections_microsoftforms_name
  location: 'australiaeast'
  kind: 'V1'
  properties: {
    displayName: 'askha@microsoft.com'
    customParameterValues: {}
    api: {
      id: '/subscriptions/9907fc36-386a-48e6-9b00-0470d5f7cab7/providers/Microsoft.Web/locations/australiaeast/managedApis/${connections_microsoftforms_name}'
    }
  }
}

resource connections_visualstudioteamservices_name_resource 'Microsoft.Web/connections@2016-06-01' = {
  name: connections_visualstudioteamservices_name
  location: 'australiaeast'
  kind: 'V1'
  properties: {
    displayName: 'askha@microsoft.com'
    customParameterValues: {}
    api: {
      id: '/subscriptions/9907fc36-386a-48e6-9b00-0470d5f7cab7/providers/Microsoft.Web/locations/australiaeast/managedApis/${connections_visualstudioteamservices_name}'
    }
  }
}

resource workflows_ado_api_name_resource 'Microsoft.Logic/workflows@2017-07-01' = {
  name: workflows_ado_api_name
  location: 'australiaeast'
  properties: {
    state: 'Enabled'
    definition: {
      '$schema': 'https://schema.management.azure.com/providers/Microsoft.Logic/schemas/2016-06-01/workflowdefinition.json#'
      contentVersion: '1.0.0.0'
      parameters: {
        '$connections': {
          defaultValue: {}
          type: 'Object'
        }
      }
      triggers: {
        When_a_new_response_is_submitted: {
          splitOn: '@triggerBody()?[\'value\']'
          type: 'ApiConnectionWebhook'
          inputs: {
            body: {
              eventType: 'responseAdded'
              notificationUrl: '@{listCallbackUrl()}'
              source: 'ms-connector'
            }
            host: {
              connection: {
                name: '@parameters(\'$connections\')[\'microsoftforms\'][\'connectionId\']'
              }
            }
            path: '/formapi/api/forms/@{encodeURIComponent(\'v4j5cvGGr0GRqy180BHbR4CtP6zfGHpGlWyPdTmcZLFUQkpFQkREU01MUjAzVkk3TEtPNFhORE5PNC4u\')}/webhooks'
          }
        }
      }
      actions: {
        'Create_a_work_item_-_Epic': {
          runAfter: {
            Get_response_details: [
              'Succeeded'
            ]
          }
          type: 'ApiConnection'
          inputs: {
            body: {
              description: '@body(\'Get_response_details\')?[\'r3edc15d76d3544cb8432f501a0fb3865\']'
              dynamicFields: {
                'System.AssignedTo': '@body(\'Get_response_details\')?[\'rb0ed29c63df7494c8045c5ec93ec525f\']'
              }
              title: '@body(\'Get_response_details\')?[\'rdefe4995ec144f9cb7589b93693d596e\']'
            }
            host: {
              connection: {
                name: '@parameters(\'$connections\')[\'visualstudioteamservices\'][\'connectionId\']'
              }
            }
            method: 'patch'
            path: '/@{encodeURIComponent(\'corp-organization\')}/_apis/wit/workitems/$@{encodeURIComponent(\'Epic\')}'
            queries: {
              account: 'askha'
            }
          }
        }
        'Create_a_work_item_-_Feature': {
          runAfter: {
            'Create_a_work_item_-_Epic': [
              'Succeeded'
            ]
          }
          type: 'ApiConnection'
          inputs: {
            body: {
              description: '@body(\'Get_response_details\')?[\'r43cab25b44474f4d9820641c91b5e2fe\']'
              dynamicFields: {
                'System.AssignedTo': '@body(\'Get_response_details\')?[\'rb0ed29c63df7494c8045c5ec93ec525f\']'
              }
              linkType: 'Hierarchy-reverse'
              linkUrl: '@body(\'Create_a_work_item_-_Epic\')?[\'url\']'
              title: '@body(\'Get_response_details\')?[\'r289e9e4b610241d5ac6c358399254a6f\']'
            }
            host: {
              connection: {
                name: '@parameters(\'$connections\')[\'visualstudioteamservices\'][\'connectionId\']'
              }
            }
            method: 'patch'
            path: '/@{encodeURIComponent(\'corp-organization\')}/_apis/wit/workitems/$@{encodeURIComponent(\'Feature\')}'
            queries: {
              account: 'askha'
            }
          }
        }
        'Create_a_work_item_-_Task': {
          runAfter: {
            'Create_a_work_item_-_Feature': [
              'Succeeded'
            ]
          }
          type: 'ApiConnection'
          inputs: {
            body: {
              description: '@body(\'Get_response_details\')?[\'r7467523c5c4d4cd7a0dd90673bea976c\']'
              dynamicFields: {
                'System.AssignedTo': '@body(\'Get_response_details\')?[\'rb0ed29c63df7494c8045c5ec93ec525f\']'
              }
              linkType: 'Hierarchy-reverse'
              linkUrl: '@body(\'Create_a_work_item_-_Feature\')?[\'url\']'
              title: '@body(\'Get_response_details\')?[\'r80fd5fc650044c09bdef0dbb7078797c\']'
            }
            host: {
              connection: {
                name: '@parameters(\'$connections\')[\'visualstudioteamservices\'][\'connectionId\']'
              }
            }
            method: 'patch'
            path: '/@{encodeURIComponent(\'corp-organization\')}/_apis/wit/workitems/$@{encodeURIComponent(\'Task\')}'
            queries: {
              account: 'askha'
            }
          }
        }
        Get_response_details: {
          runAfter: {}
          type: 'ApiConnection'
          inputs: {
            host: {
              connection: {
                name: '@parameters(\'$connections\')[\'microsoftforms\'][\'connectionId\']'
              }
            }
            method: 'get'
            path: '/formapi/api/forms(\'@{encodeURIComponent(\'v4j5cvGGr0GRqy180BHbR4CtP6zfGHpGlWyPdTmcZLFUQkpFQkREU01MUjAzVkk3TEtPNFhORE5PNC4u\')}\')/responses'
            queries: {
              response_id: '@triggerBody()?[\'resourceData\']?[\'responseId\']'
            }
          }
        }
      }
      outputs: {}
    }
    parameters: {
      '$connections': {
        value: {
          microsoftforms: {
            connectionId: connections_microsoftforms_name_resource.id
            connectionName: 'microsoftforms'
            id: '/subscriptions/9907fc36-386a-48e6-9b00-0470d5f7cab7/providers/Microsoft.Web/locations/australiaeast/managedApis/microsoftforms'
          }
          visualstudioteamservices: {
            connectionId: connections_visualstudioteamservices_name_resource.id
            connectionName: 'visualstudioteamservices'
            id: '/subscriptions/9907fc36-386a-48e6-9b00-0470d5f7cab7/providers/Microsoft.Web/locations/australiaeast/managedApis/visualstudioteamservices'
          }
        }
      }
    }
  }
}

resource workflows_ado_cascadeform_name_resource 'Microsoft.Logic/workflows@2017-07-01' = {
  name: workflows_ado_cascadeform_name
  location: 'australiaeast'
  properties: {
    state: 'Enabled'
    definition: {
      '$schema': 'https://schema.management.azure.com/providers/Microsoft.Logic/schemas/2016-06-01/workflowdefinition.json#'
      contentVersion: '1.0.0.0'
      parameters: {
        '$connections': {
          defaultValue: {}
          type: 'Object'
        }
      }
      triggers: {
        When_a_new_response_is_submitted: {
          splitOn: '@triggerBody()?[\'value\']'
          type: 'ApiConnectionWebhook'
          inputs: {
            body: {
              eventType: 'responseAdded'
              notificationUrl: '@{listCallbackUrl()}'
              source: 'ms-connector'
            }
            host: {
              connection: {
                name: '@parameters(\'$connections\')[\'microsoftforms\'][\'connectionId\']'
              }
            }
            path: '/formapi/api/forms/@{encodeURIComponent(\'v4j5cvGGr0GRqy180BHbR4CtP6zfGHpGlWyPdTmcZLFUQTdRODg1VExaUDdXNU9PQzkwVDdaVUZTMC4u\')}/webhooks'
          }
        }
      }
      actions: {
        Condition: {
          actions: {
            Create_a_work_item: {
              runAfter: {}
              type: 'ApiConnection'
              inputs: {
                body: {
                  description: '@body(\'Get_response_details\')?[\'re643aebf6725455bbc3cd28f368ff981\']'
                  dynamicFields: {
                    'System.AssignedTo': '@body(\'Get_response_details\')?[\'r0f848632ab8a41b0859843d43cafaa93\']'
                  }
                  linkType: 'Hierarchy-reverse'
                  linkUrl: '@body(\'Create_a_work_item_-_Epic\')?[\'fields\']?[\'Vsts_WorkItemUrl\']'
                  title: '@body(\'Get_response_details\')?[\'re643aebf6725455bbc3cd28f368ff981\']'
                }
                host: {
                  connection: {
                    name: '@parameters(\'$connections\')[\'visualstudioteamservices\'][\'connectionId\']'
                  }
                }
                method: 'patch'
                path: '/@{encodeURIComponent(\'corp-organization\')}/_apis/wit/workitems/$@{encodeURIComponent(\'Feature\')}'
                queries: {
                  account: 'askha'
                }
              }
            }
          }
          runAfter: {
            Initialize_variable: [
              'Succeeded'
            ]
          }
          expression: {
            and: [
              {
                not: {
                  equals: [
                    '@body(\'Get_response_details\')?[\'re643aebf6725455bbc3cd28f368ff981\']'
                    '@variables(\'nullvalue\')'
                  ]
                }
              }
            ]
          }
          type: 'If'
        }
        'Create_a_work_item_-_Epic': {
          runAfter: {
            Get_response_details: [
              'Succeeded'
            ]
          }
          type: 'ApiConnection'
          inputs: {
            body: {
              description: '@body(\'Get_response_details\')?[\'r51589c78885c47a8972c1d3b6005a6c0\']'
              title: '@body(\'Get_response_details\')?[\'r51589c78885c47a8972c1d3b6005a6c0\']'
            }
            host: {
              connection: {
                name: '@parameters(\'$connections\')[\'visualstudioteamservices\'][\'connectionId\']'
              }
            }
            method: 'patch'
            path: '/@{encodeURIComponent(\'corp-organization\')}/_apis/wit/workitems/$@{encodeURIComponent(\'Epic\')}'
            queries: {
              account: 'askha'
            }
          }
        }
        Create_a_work_item_2: {
          runAfter: {
            Condition: [
              'Succeeded'
            ]
          }
          type: 'ApiConnection'
          inputs: {
            body: {
              description: '@body(\'Get_response_details\')?[\'rab1caac84ad64639adb66fe49fe86613\']'
              title: '@body(\'Get_response_details\')?[\'rab1caac84ad64639adb66fe49fe86613\']'
            }
            host: {
              connection: {
                name: '@parameters(\'$connections\')[\'visualstudioteamservices\'][\'connectionId\']'
              }
            }
            method: 'patch'
            path: '/@{encodeURIComponent(\'corp-organization\')}/_apis/wit/workitems/$@{encodeURIComponent(\'Task\')}'
            queries: {
              account: 'askha'
            }
          }
        }
        Get_response_details: {
          runAfter: {}
          type: 'ApiConnection'
          inputs: {
            host: {
              connection: {
                name: '@parameters(\'$connections\')[\'microsoftforms\'][\'connectionId\']'
              }
            }
            method: 'get'
            path: '/formapi/api/forms(\'@{encodeURIComponent(\'v4j5cvGGr0GRqy180BHbR4CtP6zfGHpGlWyPdTmcZLFUQTdRODg1VExaUDdXNU9PQzkwVDdaVUZTMC4u\')}\')/responses'
            queries: {
              response_id: '@triggerBody()?[\'resourceData\']?[\'responseId\']'
            }
          }
        }
        Initialize_variable: {
          runAfter: {
            'Create_a_work_item_-_Epic': [
              'Succeeded'
            ]
          }
          type: 'InitializeVariable'
          inputs: {
            variables: [
              {
                name: 'nullvalue'
                type: 'string'
              }
            ]
          }
        }
      }
      outputs: {}
    }
    parameters: {
      '$connections': {
        value: {
          microsoftforms: {
            connectionId: connections_microsoftforms_name_resource.id
            connectionName: 'microsoftforms'
            id: '/subscriptions/9907fc36-386a-48e6-9b00-0470d5f7cab7/providers/Microsoft.Web/locations/australiaeast/managedApis/microsoftforms'
          }
          visualstudioteamservices: {
            connectionId: connections_visualstudioteamservices_name_resource.id
            connectionName: 'visualstudioteamservices'
            id: '/subscriptions/9907fc36-386a-48e6-9b00-0470d5f7cab7/providers/Microsoft.Web/locations/australiaeast/managedApis/visualstudioteamservices'
          }
        }
      }
    }
  }
}