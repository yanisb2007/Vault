document.addEventListener('DOMContentLoaded', () => {
    const filterButtons = document.querySelectorAll('.filter');
    const cards = Array.from(document.querySelectorAll('.carte'));
    const libraryCount = document.getElementById('library-count');
    const headerSearch = document.querySelector('.header-search');
    const catalogSearch = document.querySelector('.search-input');
    const sortSelect = document.querySelector('.sort-select');

    if (!cards.length) {
        return;
    }

    let activeFilter = 'all';

    function getSearchTerm() {
        const value = (catalogSearch?.value ?? headerSearch?.value ?? '').trim().toLowerCase();
        return value;
    }

    function applyFilters() {
        const query = getSearchTerm();
        const parent = cards[0].parentElement;
        const filteredCards = cards.filter((card) => {
            const categoryMatches = activeFilter === 'all' || card.dataset.category === activeFilter;
            const text = `${card.dataset.title || ''} ${card.querySelector('h3')?.textContent ?? ''} ${card.querySelector('p')?.textContent ?? ''}`.toLowerCase();
            const matchesQuery = !query || text.includes(query);
            return categoryMatches && matchesQuery;
        });

        if (sortSelect && sortSelect.value === 'title') {
            filteredCards.sort((a, b) => {
                const titleA = (a.dataset.title || a.querySelector('h3')?.textContent || '').localeCompare(
                    b.dataset.title || b.querySelector('h3')?.textContent || ''
                );
                return titleA;
            });
        }

        cards.forEach((card) => {
            card.style.display = 'none';
        });

        filteredCards.forEach((card) => {
            card.style.display = 'block';
            parent.appendChild(card);
        });

        if (libraryCount) {
            const total = cards.length;
            const visible = filteredCards.length;
            const label = visible > 1 ? 'œuvres' : 'œuvre';
            const suffix = visible > 1 ? 's' : '';
            libraryCount.textContent = `${visible} ${label} affich${suffix}ée${suffix} sur ${total}`;
        }
    }

    filterButtons.forEach((button) => {
        button.addEventListener('click', () => {
            activeFilter = button.dataset.filter || 'all';
            filterButtons.forEach((btn) => btn.classList.toggle('active', btn === button));
            applyFilters();
        });
    });

    [catalogSearch, headerSearch].forEach((input) => {
        input?.addEventListener('input', applyFilters);
    });

    sortSelect?.addEventListener('change', applyFilters);
    applyFilters();
});
