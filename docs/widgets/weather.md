# Weather widget

`LesliView::Widgets::Weather` presents a temperature, location, condition, and Material Symbol icon. It is a display component; fetching weather data remains the application's responsibility.

```erb
<%= render LesliView::Widgets::Weather.new(
    Time.current,
    temperature: 24,
    location: "Guatemala City",
    condition: "Partly cloudy",
    unit: "C",
    icon: "partly_cloudy_day"
) %>
```

`unit:` accepts `C` or `F` case-insensitively and falls back to `C`. A missing temperature renders an em dash. A missing condition uses the translated showers label, and a missing icon falls back to `rainy`. The positional date is retained by the API but is not currently displayed.
