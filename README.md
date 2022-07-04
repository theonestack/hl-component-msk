# msk CfHighlander Component

![cftest](https://github.com/theonestack/hl-component-msk/actions/workflows/rspec.yaml/badge.svg)

Creates a Amazon Managed Streaming for Apache Kafka (MSK)

```bash
kurgan add msk
```

## Requirements

## Parameters

| Name | Use | Default | Global | Type | Allowed Values |
| ---- | --- | ------- | ------ | ---- | -------------- |
| EnvironmentName | Tagging | dev | true | string
| EnvironmentType | Tagging | development | true | string | ['development','production']

## Configuration

TODO: Add configuration examples

**Other Config Options**

See the test configs in the [tests directory](tests/)

## Outputs/Exports

| Name | Value | Exported |
| ---- | ----- | -------- |


## Development

```bash
gem install cfhighlander
```

or via docker

```bash
docker pull theonestack/cfhighlander
```

### Testing

Generate cftest

```bash
kurgan test example
```

Run cftest

```bash
cfhighlander cftest -t tests/example.test.yaml
```

or run all tests

```bash
cfhighlander cftest
```

Generate spec tests

```bash
kurgan test example --type spec
```

run spec tests

```bash
gem install rspec
```

```bash
rspec
```