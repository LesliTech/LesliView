<div align="center">
    <h1 align="center">
        <img width="100" alt="LesliView" src="./docs/images/view-logo.svg" />
    </h1>
    <h3 align="center">Reusable Rails components and form builders for the Lesli Framework.</h3>
</div>

<br />

<div align="center">
    <a target="_blank" href="https://github.com/LesliTech/LesliView/actions/workflows/lesli-ci-gem.yaml">
        <img
            alt="LesliView test status"
            src="https://img.shields.io/github/actions/workflow/status/LesliTech/LesliView/lesli-ci-gem.yaml?branch=main&style=for-the-badge&logo=github&label=tests">
    </a>
    <a target="_blank" href="https://rubygems.org/gems/lesli_view">
        <img alt="Gem Version" src="https://img.shields.io/gem/v/lesli_view?style=for-the-badge&logo=ruby">
    </a>
    <a target="_blank" href="https://codecov.io/github/LesliTech/LesliView">
        <img alt="Codecov" src="https://img.shields.io/codecov/c/github/LesliTech/LesliView?style=for-the-badge&logo=codecov">
    </a>
    <a target="_blank" href="https://sonarcloud.io/project/overview?id=LesliTech_LesliView">
        <img alt="Sonar Quality Gate" src="https://img.shields.io/sonar/quality_gate/LesliTech_LesliView?server=https%3A%2F%2Fsonarcloud.io&style=for-the-badge&logo=sonarqubecloud&label=Quality">
    </a>
</div>

<br />

## Introduction

LesliView is the official user-interface library for the [Lesli Framework](https://github.com/LesliTech/Lesli). It packages the framework's shared interface patterns as ViewComponent-powered components, Rails form builders, and domain-oriented views.

Use LesliView to build consistent server-rendered interfaces without recreating common layouts, controls, forms, and application states in every Lesli engine.

<br />

## Why LesliView?

LesliView provides:

- A shared visual language across Lesli applications and engines
- Composable, testable components built with ViewComponent
- Rails-native form builders with consistent labels, controls, messages, and actions
- Reusable views for common product concepts such as activities, attachments, discussions, and tasks
- Responsive presentation based on Tailwind CSS utility classes
- Accessible defaults for labels, button states, navigation, and page actions

<br />

## Quick Start

### Requirements

The current development baseline is:

- Ruby 3.3 or newer (the release workflow uses Ruby 3.3.5)
- Rails 8.1
- LesliAssets, configured in the host application's asset build

ViewComponent and Lexxy are installed as runtime dependencies of LesliView.

### Install with Lesli

LesliView and LesliAssets are installed automatically with the main `lesli` gem. No additional gem or asset configuration is required in a standard Lesli application.

### Install in another Rails application

Add LesliView to the application:

```shell
bundle add lesli_view
```

For the complete Lesli presentation layer, also install the shared assets package:

```shell
bundle add lesli_assets
```

The host application must configure LesliAssets in its asset build so the Lesli styles and icon fonts are available before rendering the components.

<br />

## Usage

### Build a page header

Compose a layout and header directly from an ERB template:

```erb
<%= render LesliView::Layout::Container.new("tickets") do %>
    <%= render LesliView::Components::Header.new(
        "Tickets",
        "Manage customer requests and follow-up work.",
        new_path: new_ticket_path,
        new_label: "Create ticket"
    ) %>
<% end %>
```

### Render an action

Elements provide focused interface primitives with consistent behavior and styling:

```erb
<%= render LesliView::Elements::Button.new(
    "Create ticket",
    icon: "add",
    url: new_ticket_path
) %>
```

### Build a form

Pass the LesliView builder to the standard Rails form helpers:

```erb
<%= form_with(model: @ticket, builder: LesliView::Forms::Builder) do |form| %>
    <%= form.field_control_text :subject %>
    <%= form.field_control_textarea :description %>
    <%= form.field_control_submit "Save ticket" %>
<% end %>
```

<br />

## Library

LesliView organizes its public interface into focused groups:

| Group | Included building blocks |
| --- | --- |
| Charts | Bar, line, and general chart rendering |
| Components | Headers, panels, tabs, timelines, and toolbars |
| Elements | Avatars, buttons, empty states, and tables |
| Forms | Standard and horizontal builders, fields, inputs, and fieldsets |
| Items | Actions, activities, attachments, discussions, and tasks |
| Layouts | Shared application containers |
| Partials | Reusable engine information |
| Widgets | Calendars, charts, counters, dates, and weather |

See the [LesliView documentation](https://www.lesli.dev/gems/view/) for component options and additional examples.

- [Installation](https://www.lesli.dev/gems/view/about/installation)
- [Components](https://www.lesli.dev/gems/view/components)
- [Elements](https://www.lesli.dev/gems/view/elements)
- [Forms](https://www.lesli.dev/gems/view/forms)
- [Charts](https://www.lesli.dev/gems/view/charts)
- [Widgets](https://www.lesli.dev/gems/view/widgets)

<br />

## Development

Clone the repository and install its dependencies:

```shell
git clone https://github.com/LesliTech/LesliView.git
cd LesliView
bundle install
```

Run the default test suite:

```shell
bundle exec rake
```

To develop LesliView inside a local Lesli workspace, reference the repository from the host application's `Gemfile`:

```ruby
gem "lesli_view", path: "gems/LesliView"
```

Then run `bundle install` from the host application so changes to the local gem are loaded immediately.

<br />

## Documentation

- [Lesli website](https://www.lesli.dev/)
- [LesliView documentation](https://www.lesli.dev/gems/view/)
- [Releases and changelog](https://github.com/LesliTech/LesliView/releases)
- [Issue tracker](https://github.com/LesliTech/LesliView/issues)
- [Source code](https://github.com/LesliTech/LesliView)

<br />

## Community

- [X: @LesliTech](https://x.com/LesliTech)
- [hello@lesli.tech](mailto:hello@lesli.tech)
- [https://www.lesli.tech](https://www.lesli.tech)

<br />

## License

Copyright (c) 2026, Lesli Technologies, S. A.

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program. If not, see [https://www.gnu.org/licenses/](https://www.gnu.org/licenses/).

The complete license text is available in the [license file](./license).

---

<br />
<br />

<div align="center">
    <img width="80" alt="Lesli icon" src="https://cdn.lesli.tech/lesli/brand/app-icon.svg" />
    <h3 align="center">The Open-Source SaaS Development Framework for Ruby on Rails.</h3>
</div>
