# 🎨 Tailwind CSS Configuration Guide

Welcome to the Photo App! This repository uses **Tailwind CSS v4** for modern, utility-first styling. Below you'll find everything you need to know about our CSS setup and how to contribute.

## 📋 Current Setup Overview

This project integrates Tailwind CSS seamlessly with Rails using the official `tailwindcss-rails` gem. Here's what we have configured:

### Dependencies
- **tailwindcss-rails** gem for Rails integration
- **Tailwind CSS v4** (latest version)
- **Foreman** for concurrent process management during development

### Key Files & Directories
- `app/assets/tailwind/application.css` - Main Tailwind source file with custom components
- `Procfile.dev` - Manages Rails server + Tailwind watcher processes
- `bin/dev` - Development startup script
- `tailwind.config.js` - Tailwind configuration (content paths, plugins, etc.)
- `package.json` - Node.js dependencies for additional Tailwind plugins

### Custom Design System
I've created some reusable component classes for consistency:
- `.btn-primary` - Primary action buttons (blue theme)
- `.btn-secondary` - Secondary buttons (gray theme)  
- `.card` - Content cards with shadow and hover effects

### Demo Implementation
Check out `app/views/welcome/index.html.erb` to see Tailwind in action:
- Responsive grid layouts
- Gradient backgrounds
- Custom component usage
- SVG icon integration
- Mobile-first responsive design

## 🚀 Development Workflow

### Quick Start
Clone the repository and get started with these commands:

```bash
# Install dependencies
bundle install

# Start development environment (Rails + Tailwind watcher)
bin/dev
```

The development server will be available at `http://localhost:3000` with hot-reloading CSS.

### Manual CSS Operations
If you need to build CSS separately:

```bash
# One-time build
rails tailwindcss:build

# Watch for changes during development
rails tailwindcss:watch
```

### Contributing Styles
When adding new styles to the project:

1. **Use utility classes first** - Tailwind's utilities cover most use cases
2. **Create components for repeated patterns** - Add them to `app/assets/tailwind/application.css`
3. **Follow the existing naming convention** - Use descriptive, semantic names
4. **Test responsive behavior** - Ensure mobile-first approach

Example of adding a new component:
```erb
<!-- In your ERB templates -->
<div class="bg-blue-500 text-white p-4 rounded-lg shadow-md hover:shadow-lg transition-shadow">
  <h1 class="text-2xl font-bold">Photo Title</h1>
  <button class="btn-primary mt-4">View Details</button>
</div>
```

## 📁 Project Structure

Our Tailwind CSS integration follows Rails conventions:

```
app/
├── assets/
│   ├── builds/              # Auto-generated CSS (ignored by git)
│   ├── stylesheets/
│   │   └── application.css  # Rails asset manifest
│   └── tailwind/
│       └── application.css  # Tailwind source + custom components
├── views/
│   ├── layouts/
│   │   └── application.html.erb
│   └── welcome/
│       └── index.html.erb   # Demo page with Tailwind examples
```

## ⚙️ Customization Guide

### Adding Brand Colors
Extend the color palette in `tailwind.config.js`:

```javascript
module.exports = {
  content: [
    './app/views/**/*.{erb,haml,html,slim}',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js'
  ],
  theme: {
    extend: {
      colors: {
        'brand-primary': '#1DA1F2',
        'brand-secondary': '#14171A',
        'photo-accent': '#FF6B6B'
      }
    }
  }
}
```

### Creating Custom Components
Add reusable components to `app/assets/tailwind/application.css`:

```css
@layer components {
  .photo-card {
    @apply bg-white rounded-xl shadow-lg overflow-hidden hover:shadow-xl transition-shadow duration-300;
  }
  
  .upload-zone {
    @apply border-2 border-dashed border-gray-300 rounded-lg p-8 text-center hover:border-blue-400 transition-colors;
  }
}
```

## � Troubleshooting

### Common Issues & Solutions

**CSS not loading or updating?**
1. Ensure development server is running: `bin/dev`
2. Force rebuild CSS: `rails tailwindcss:build`
3. Check browser cache - try hard refresh (Ctrl+F5)
4. Verify `<%= stylesheet_link_tag :app %>` is in your layout

**Build errors during deployment?**
- Make sure `tailwindcss-rails` gem is not in a development-only group
- Ensure all required files are committed to git
- Check that the production environment can access view templates for purging

**Styles not being purged correctly?**
- Review content paths in `tailwind.config.js`
- Ensure dynamic class names are included in purge safelist
- Check that all template file extensions are covered

### Performance Notes
- Production builds automatically purge unused CSS
- Generated CSS is minified and optimized
- Consider using `@apply` sparingly to keep bundle size small

## 🛠 Development Tips

1. **Use Tailwind IntelliSense** - Install the VS Code extension for autocomplete
2. **Responsive Design** - Always start with mobile (`sm:`, `md:`, `lg:`, `xl:`)
3. **Component Organization** - Group related utility classes logically
4. **Performance** - Prefer utilities over custom CSS when possible

## 📚 Additional Resources

- [Tailwind CSS Documentation](https://tailwindcss.com) - Official docs
- [Tailwind CSS Rails Gem](https://github.com/rails/tailwindcss-rails) - Integration guide
- [Tailwind UI Components](https://tailwindui.com) - Premium component library
- [Headless UI](https://headlessui.com) - Unstyled, accessible components

---

**Happy coding!** Feel free to contribute improvements to our design system. 🎨
