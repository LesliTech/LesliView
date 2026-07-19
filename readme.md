<div align="center">
    <h1 align="center">
        <img width="100" alt="LesliView" src="./docs/images/view-logo.svg" />
    </h1>
    <h3 align="center">Reusable Rails components and form builders for the Lesli Framework.</h3>
</div>

<br />

<div align="center">
    <a target="_blank" href="https://github.com/LesliTech/LesliView/actions/workflows/main.yml">
        <img
            alt="LesliView test status"
            src="https://img.shields.io/github/actions/workflow/status/LesliTech/LesliView/main.yml?branch=main&style=for-the-badge&logo=github&label=tests">
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

---

<br />

## Introduction

LesliView is the official user-interface library for the [Lesli Framework](https://github.com/LesliTech/Lesli).

It combines ViewComponent-powered building blocks, Rails form builders, and shared interface patterns to help Lesli applications remain consistent, reusable, and maintainable.

<br />

## Features

- Reusable Rails ViewComponents
- Form builders with consistent fields, inputs, and fieldsets
- Application layout and navigation components
- Buttons, tables, avatars, and empty states
- Charts, calendars, counters, dates, and weather widgets
- Tasks, discussions, activities, and attachment interfaces
- Shared Tailwind-based presentation for Lesli applications

<br />

## Installation

Add LesliView to the Rails application:

```shell
bundle add lesli_view
```

Bundler installs ViewComponent and the other required runtime dependencies automatically.

<br />

## Usage

### Render a component

Render LesliView components from any Rails template:

```erb
<%= render(LesliView::Layout::Container.new("tickets")) do %>
    <%= render(LesliView::Components::Header.new("Tickets")) %>
<% end %>
```

### Render an element

Elements provide smaller interface building blocks:

```erb
<%= render(
    LesliView::Elements::Button.new(
        "Create ticket",
        icon: "add",
        solid: true,
        url: new_ticket_path
    )
) %>
```

### Use the form builder

Pass the LesliView builder to Rails form helpers:

```erb
<%= form_with(
    model: @ticket,
    builder: LesliView::Forms::Builder
) do |form| %>
    <%= form.field_control_text :subject %>
    <%= form.field_control_textarea :description %>
    <%= form.field_control_submit "Save ticket" %>
<% end %>
```

<br />

## Library

LesliView organizes its interface building blocks into focused groups:

- **Charts:** bar, line, and general chart rendering
- **Components:** headers, panels, tabs, timelines, and toolbars
- **Elements:** avatars, buttons, empty states, and tables
- **Forms:** standard and horizontal builders, fields, inputs, and fieldsets
- **Items:** actions, activities, attachments, discussions, and tasks
- **Layouts:** shared application containers
- **Partials:** reusable engine information
- **Widgets:** calendars, charts, counters, dates, and weather

Detailed examples and available options are maintained in the [LesliView documentation](https://www.lesli.dev/gems/view/).

<br />

## Development

Clone the repository and install its dependencies:

```shell
git clone https://github.com/LesliTech/LesliView.git
cd LesliView
bundle install
```

To develop LesliView inside a Rails workspace, reference the local source from the host application's `Gemfile`:

```ruby
gem "lesli_view", path: "gems/LesliView"
```

### Tests

Run the default test task from the LesliView directory:

```shell
bundle exec rake
```

<br />

## Documentation

- [Lesli website](https://www.lesli.dev/)
- [Documentation](https://www.lesli.dev/gems/view/)
- [Release notes](https://github.com/LesliTech/LesliView/releases)
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
