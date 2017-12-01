# SPIRE Agent

SPIRE Agent runs on every node and is responsible for requesting certificates from the spire server,
attesting the validity of local workloads, and providing them SVIDs.

## Agent configuration file

The following details the configurations for the spire agent. The configurations can be set through
.conf file or passed as command line args, the command line configurations takes precedence.

| Configuration     | Description                                                    | Default                |
| ----------------- | -------------------------------------------------------------- | ---------------------- |
| `bindAddress`     | IP address or DNS name of the SPIRE server                     |                        |
| `bindPort`        | Port number of the SPIRE server                                |                        |
| `dataDir`         | A directory the agent can use for its runtime data             | $PWD                   |
| `logFile`         | File to write logs to                                          |                        |
| `logLevel`        | Sets the logging level \<DEBUG\|INFO\|WARN\|ERROR\>            | INFO                   |
| `pluginDir`       | Plugin conf.d configuration directory                          | $PWD/conf/agent/plugin |
| `serverAddress`   | IP address or DNS name of the SPIRE server                     |                        |
| `serverPort`      | Port number of the SPIRE server                                |                        |
| `socketPath`      | Location to bind the workload API socket                       | $PWD/spire_api         |
| `trustBundlePath` | Path to the SPIRE server CA bundle                             |                        |
| `trustDomain`     | The trust domain that this agent belongs to                    |                        |
| `joinToken`       | An optional token which has been generated by the SPIRE server |                        |
| `umask`           | Umask value to use for new files                               | 0077                   |

**Note:** Changing the umask may expose your signing authority to users other than the SPIRE
agent/server

## Plugin configuration files

Each file in the directory `pluginDir` is expected to contain the configration for one plugin. The
following copnfiguration options must be present in each file

| Configuration  | Description                             |
| -------------- | --------------------------------------- |
| pluginName     | A unique name that describes the plugin |
| pluginChecksum | An optional sha256 of the plugin binary |
| enabled        | Enable or disable the plugin            |
| pluginType     | The plugin type (see below)             |
| pluginData     | Plugin-specific data                    |

## Command line options

### `spire-agent run`

All of the configuration file above options have identical command-line counterparts. In addition,
the following flags are available.

| Command          | Action                      | Default                 |
| ---------------- | --------------------------- | ----------------------- |
| `-config string` | Path to a SPIRE config file | conf/server/server.conf |

## Architechture

The agent consists of a master process (spire-agent) and three plugins - the Node Attestor, the
Workload Attestor and the Key Manager. The master process implements the Workload API and
communicates with spire-server via the Node API.

![spire agent architecture](images/SPIRE_agent.png)

## Available plugins

| Type             | Name                                                                            | Description |
| ---------------- | ------------------------------------------------------------------------------- | ----------- |
| KeyManager       | [keymanager-memory](/doc/plugin_agent_keymanager_memory.md)                     |             |
| NodeAttestor     | [nodeattestor-jointoken](/doc/plugin_agent_nodeattestor_jointoken.md)           |             |
| WorkloadAttestor | [workloadattestor-secretfile](/doc/plugin_agent_workloadattestor_secretfile.md) |             |
| WorkloadAttestor | [workloadattestor-unix](/doc/plugin_agent_workloadattestor_unix.md)             |             |

## Further reading

* [SPIFFE Reference Implementation Architecture](https://docs.google.com/document/d/1nV8ZbYEATycdFhgjTB619pwIvamzOjU6l0SyBGbzbo4/edit#)
* [Design Document: SPIFFE Reference Implementation (SRI)](https://docs.google.com/document/d/1RZnBfj8I5xs8Yi_BPEKBRp0K3UnIJYTDg_31rfTt4j8/edit#)